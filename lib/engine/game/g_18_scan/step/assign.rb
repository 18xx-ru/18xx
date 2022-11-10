# frozen_string_literal: true

require_relative '../../../step/assign'

module Engine
  module Game
    module G18Scan
      module Step
        class Assign < Engine::Step::Assign
          def process_assign(action)
            company = action.entity
            target = action.target

            price = @game.class::TOKEN_PRICES[company.sym]

            raise GameError, "#{target.name} already owns a token from #{company.name}" if target.assigned?(company&.id)

            if assignable_corporations(company).include?(target) &&
              (ability = @game.abilities(company, :assign_corporation))

              raise GameError, 'No tokens left' unless ability.count.positive?

              if buying_power(target) < price
                raise GameError, "#{target.name} may not spend #{@game.format_currency(price)} on token from #{company.name}"
              end

              target.assign!(company.id)
              target.spend(price, @game.bank)

              ability.use!

              @log << "#{target.name} buys a token from #{company.name} for #{@game.format_currency(price)}"

              company.close! if ability.count.zero?
            else
              raise GameError, "Could not buy a token from #{company.name}; no assignable corporations found"
            end
          end
        end
      end
    end
  end
end

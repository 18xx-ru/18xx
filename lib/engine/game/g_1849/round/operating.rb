# frozen_string_literal: true

require_relative '../../../round/operating'

module Engine
  module Game
    module G1849
      module Round
        class Operating < Engine::Round::Operating
          attr_reader :issued_bond, :redeemed_bond

          def setup
            @issued_bond = {}
            @redeemed_bond = {}

            super
          end

          def next_entity!
            return @game.end_game! if @entities[@entity_index].reached_max_value

            super
          end

          def cash_crisis_entity
            @game.corporations.find { |corp| corp.cash.negative? }
          end
        end
      end
    end
  end
end

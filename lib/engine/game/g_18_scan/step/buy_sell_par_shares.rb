# frozen_string_literal: true

require_relative '../../../step/buy_sell_par_shares'

module Engine
  module Game
    module G18Scan
      module Step
        class BuySellParShares < Engine::Step::BuySellParShares
          def round_state
            super.merge(
              {
                companies_pending_par: [],
              }
            )
          end

          def get_par_prices(entity, corp)
            return super unless corp == @game.sj

            @game.stock_market.par_prices.select do |p|
              p.price == @game.class::SJ_START_PRICE && p.price * 2 <= entity.cash
            end
          end

          def process_buy_company(action)
            super

            @game.after_buy_company(action.entity, action.company, action.price)
          end
        end
      end
    end
  end
end

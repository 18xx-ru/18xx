# frozen_string_literal: true

require_relative '../../../step/bid_to_buy_auction'

module Engine
  module Game
    module G18Scan
      module Step
        class BuyCert < Engine::Step::BidToBuyAuction
          def setup
            super

            @purchased = false
            @all_passed = false
          end

          # allow making a bid of 0
          def min_player_bid
            any_bids? ? super : 0
          end

          # 0 is a valid bid
          def any_bids?
            in_auction? && !@bids.max_by { |_k, v| v }.last.negative?
          end

          def round_state
            {
              companies_pending_par: [],
            }
          end

          def resolve_auction
            if @bids.none?
              @all_passed = true

              # end round if all passed after something was already bought
              return all_passed! if @purchased
            end

            super
          end

          # move all unsold companies to bank pool
          def all_passed!
            until (company = @companies.shift).nil?
              company.owner = @game.bank
            end

            @game.log << 'Unsold companies transfer to the bank pool'
          end

          def buy_company(player, company, price)
            super

            @purchased = true

            # end round if all passed on first bid
            all_passed! if @all_passed
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require_relative '../../../step/bid_to_buy_auction'
require_relative '../../../action/par'

module Engine
  module Game
    module G1860
      module Step
        class BuyCert < Engine::Step::BidToBuyAuction
          attr_reader :companies

          BUY_ACTION = %w[bid par].freeze

          def init_companies
            @game.companies.select { |c| @game.abilities(c, :exchange) }.sort +
              @game.corporations.select { |c| @game.corp_layer(c) == 1 }
          end

          def name
            'Buy/Par'
          end

          def buy_description
            'You must buy a company or start a corporation'
          end

          def finished?
            @companies.empty?
          end

          def actions(entity)
            return [] if finished?
            return [] unless entity == current_entity
            return BUY_ACTION unless in_auction?
            return AUCTION_ACTIONS if min_player_bid + cheapest_price <= entity.cash

            PASS_ACTION
          end

          def process_par(action)
            share_price = action.share_price
            corporation = action.corporation
            entity = action.entity
            raise GameError, "#{corporation} cannot be parred" unless @game.can_par?(corporation, entity)

            @game.stock_market.set_par(corporation, share_price)
            shares = corporation.shares.first
            if entity.cash >= 2 * share_price.price
              @game.share_pool.buy_shares(entity, shares)
            else
              buy_discounted_shares(entity, shares, entity.cash)
            end
            @companies.delete(corporation)
            @round.next_entity_index!
            setup_auction
          end

          def get_par_prices(entity, corp)
            prices = @game.par_prices(corp).select { |p| p.price * 2 <= entity.cash }
            if prices.empty? && cheapest_thing.corporation?
              # assumes all corps available have same minimum par price
              return [@game.par_prices(corp).min_by(&:price)]
            end

            prices
          end

          def cheapest_thing
            @companies.min_by { |c| c.company? ? c.value : @game.par_prices(c).map(&:price).min * 2 }
          end

          def cheapest_price
            thing = cheapest_thing
            thing.company? ? thing.value : @game.par_prices(thing).map(&:price).min * 2
          end

          def can_afford?(entity, company)
            # guaranteed to be able to afford the cheapest company or corporation
            return true if !in_auction? && company == cheapest_thing
            return true if !in_auction? && company.corporation? && cheapest_thing.corporation?

            cost = company.company? ? company.value : @game.par_prices(company).map(&:price).min * 2
            entity.cash >= cost
          end

          def buy_discounted_shares(entity, shares, discounted_price)
            bundle = shares.is_a?(ShareBundle) ? shares : ShareBundle.new(shares)
            corporation = bundle.corporation
            par_price = corporation.par_price&.price
            ipoed = corporation.ipoed

            corporation.ipoed = true if bundle.presidents_share

            if ipoed != corporation.ipoed
              @log << "#{entity.name} pars #{corporation.name} at "\
                      "#{@game.format_currency(par_price)}"
            end

            share_str = "a #{bundle.percent}% share of #{corporation.name}"

            @log << "#{entity.name} buys #{share_str} "\
                    "from the #{@game.ipo_name(corporation)} "\
                    "for #{@game.format_currency(discounted_price)}"

            @game.share_pool.transfer_shares(
              bundle,
              entity,
              spender: entity,
              receiver: @game.bank,
              price: discounted_price
            )
          end

          def companies_pending_par
            false
          end

          def buy_company(player, company, listed_price)
            super(player, company, [listed_price, player.cash].min)
          end
        end
      end
    end
  end
end

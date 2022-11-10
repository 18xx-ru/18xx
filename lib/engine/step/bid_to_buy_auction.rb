# frozen_string_literal: true

require_relative 'base'

module Engine
  module Step
    class BidToBuyAuction < Base
      attr_reader :companies

      AUCTION_ACTIONS = %w[bid pass].freeze
      BUY_ACTION = %w[bid].freeze
      PASS_ACTION = %w[pass].freeze
      MIN_BID_RAISE = 5

      def setup
        @companies = init_companies
        @bids = {}
        setup_auction
      end

      def init_companies
        @game.companies.sort
      end

      def available
        @companies.select { |c| can_afford?(current_entity, c) }
      end

      def may_purchase?(_company)
        true
      end

      def auctioning
        :turn if in_auction?
      end

      def bids
        {}
      end

      def visible?
        true
      end

      def players_visible?
        true
      end

      def name
        'Buy'
      end

      def description
        in_auction? ? 'Bid on turn to buy' : buy_description
      end

      def buy_description
        'You must buy a company'
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

      def process_pass(action)
        player = action.entity

        @log << "#{player.name} passes bidding"

        @bids.delete(player)

        resolve_auction
      end

      def process_bid(action)
        player = action.entity
        price = action.price

        if !in_auction?
          buy_company(player, action.company, price)
        else
          if price > max_player_bid(player)
            raise GameError, "Cannot afford bid. Maximum possible bid is #{max_player_bid(player)}"
          end

          raise GameError, "Must bid at least #{min_player_bid}" if price < min_player_bid

          @log << "#{player.name} bids #{@game.format_currency(price)}"

          @bids[player] = price
          resolve_auction
        end
      end

      def active_entities
        return [@bids.min_by { |_k, v| v }.first] if in_auction?

        super
      end

      def min_increment
        1
      end

      def min_player_bid
        highest_player_bid + MIN_BID_RAISE
      end

      def max_player_bid(entity)
        entity.cash - cheapest_price
      end

      def min_bid(company)
        return unless company

        company.value
      end

      def visible
        true
      end

      def committed_cash(player, _show_hidden = false)
        if @bids[player] && !@bids[player].negative?
          @bids[player] + cheapest_price
        else
          0
        end
      end

      private

      def in_auction?
        @bids.any?
      end

      def highest_player_bid
        any_bids? ? @bids.max_by { |_k, v| v }.last : 0
      end

      def highest_bid
        in_auction? ? @bids.max_by { |_k, v| v }.last : 0
      end

      def any_bids?
        in_auction? && @bids.max_by { |_k, v| v }.last.positive?
      end

      def cheapest_thing
        @companies.min_by(&:value)
      end

      def cheapest_price
        cheapest_thing.value
      end

      def setup_auction
        @bids.clear
        @first_player = current_entity
        start_idx = entity_index
        size = entities.size

        # initialize bids to preserve player order starting with current player
        entities.each_index do |idx|
          @bids[entities[idx]] = -size + ((idx - start_idx) % size)
        end
      end

      def resolve_auction
        return if @bids.size > 1
        return if @bids.one? && highest_bid.negative?

        if @bids.any?
          winning_bid = @bids.to_a.flatten
          player = winning_bid.first
          price = winning_bid.last
          player.spend(price, @game.bank) if price.positive?
        else
          player = @first_player
          price = 0
        end

        @log << "#{player.name} wins auction for #{@game.format_currency(price)}"

        @bids.clear
        @round.goto_entity!(player)
      end

      def can_afford?(entity, company)
        entity.cash >= company.value
      end

      def buy_company(player, company, price)
        company.owner = player
        player.companies << company
        player.spend(price, @game.bank) if price.positive?

        @log << "#{player.name} buys #{company.name} for #{@game.format_currency(price)}"

        @companies.delete(company)

        @game.after_buy_company(player, company, price)

        @round.next_entity_index!

        setup_auction
      end
    end
  end
end

# frozen_string_literal: true

require './spec/spec_helper'

require 'engine/game/g_1889'
require 'engine/part/city'
require 'json'

module Engine
  describe Game::G1889 do
    let(:players) { [Player.new('a'), Player.new('b')] }
    subject { Game::G1889.new(players) }

    context 'on init' do
      it 'starts with correct cash' do
        expect(subject.bank.cash).to eq(6160)
        expect(subject.players.map(&:cash)).to eq([420, 420])
      end

      it 'starts with an auction' do
        expect(subject.round).to be_a(Round::Auction)
      end
    end

    context 'full game' do
      GAMES = {
        104 => {
          'Gandhalf' => 7174,
          'hoffmansthal' => 6627,
          'sharunasbresson' => 7490,
        },
        105 => {
          'Batto' => 7464,
          'XB' => 9036,
          'akramer16' => 8587,
        },
        133 => {
          'Michaël' => 3280,
          'Musashi_Daryl' => 4131,
          'Rannek' => 3153,
          'franssua' => 1697,
        },
      }.freeze

      GAMES.each do |game_id, result|
        it "#{game_id} matches result exactly" do
          data = JSON.parse(File.read("spec/fixtures/1889/#{game_id}.json"))
          expect(subject.class.new(data['players'], actions: data['actions']).result).to eq(result)
        end
      end
    end
  end
end

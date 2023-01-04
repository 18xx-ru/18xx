# frozen_string_literal: true

module Engine
  module Game
    module G1880
      module Entities
        COMPANIES = [
          {
            name: 'Woosong Railway',
            sym: 'P0',
            value: 5,
            revenue: 0,
            desc: 'Owner recieves one-off payment of 40/70/100 when last 2+2/3/3+3 train is purchased',
            color: nil,
          },
          {
            name: 'Kaiping Railway',
            sym: 'P1',
            value: 10,
            revenue: 5,
            desc: 'No Special Power',
            color: nil,
          },
          {
            name: 'Yanda Ferry Company',
            sym: 'P2',
            value: 25,
            revenue: 10,
            desc: 'The owner may use all ferries for free with all his companies',
            color: nil,
          },
          {
            name: 'Taiwan Western Line',
            sym: 'P3',
            value: 45,
            revenue: 15,
            desc: 'For the owner, the value of Taiwan is +20 (with all his companies)',
            color: nil,
          },
          {
            name: 'Chinese Rivers Ferry Companies',
            sym: 'P4',
            value: 70,
            revenue: 20,
            desc: 'Reduce the cost of laying a tile in a river hex by ¥20 (for all his companies)',
            color: nil,
          },
          {
            name: 'Jeme Tien Yow Engineer Office',
            sym: 'P5',
            value: 100,
            revenue: 25,
            desc: 'Building permit for Phase D (for one of his companies)',
            color: nil,
          },
          {
            name: 'Imperial Qing Government',
            sym: 'P6',
            value: 160,
            revenue: 0,
            desc: 'The owner receives the 20% Director’s Certificates of the BCR, BCR may always lay 2 yellow tiles',
            color: nil,
          },
          {
            name: 'Rocket of China',
            sym: 'P7',
            value: 50,
            revenue: 0,
            desc: 'The owner may exchange the Rocket of China for a currently available train, '\
                  'for one of his companies, during that company’s turn in an Operating Round. '\
                  'Forced exchange into second 4-train.',
            color: nil,
          },
        ].freeze

        CORPORATIONS = [
          {
            float_percent: 20,
            sym: 'JHA',
            logo: '1880/JHA',
            name: 'Jingha Railway',
            tokens: [0, 40, 100],
            coordinates: 'F8',
            color: '#BA6128',
          },
          {
            float_percent: 20,
            sym: 'JHU',
            name: 'Jinghu Railway',
            logo: '1830/JHU',
            tokens: [0, 40, 100],
            coordinates: 'F8',
            color: 'black',
          },
          {
            float_percent: 20,
            sym: 'JGG',
            name: 'Jingguang Railway',
            logo: '1830/JGG',
            tokens: [0, 40, 100],
            coordinates: 'F8',
            color: '#534074',
          },
          {
            float_percent: 20,
            sym: 'JLR',
            name: 'Jinglan Railway',
            logo: '1830/JLR',
            tokens: [0, 40, 100],
            coordinates: 'F8',
            color: '#008A8B',
          },
          {
            float_percent: 20,
            sym: 'BCU',
            name: 'Binzhou Railway',
            logo: '1830/BCU',
            tokens: [0, 40, 100],
            coordinates: 'B8',
            color: '#9D8359',
          },
          {
            float_percent: 20,
            sym: 'LHR',
            name: 'Longhai Railway',
            logo: '1830/LHR',
            tokens: [0, 40, 100],
            coordinates: 'J2',
            color: '#004294',
          },
          {
            float_percent: 20,
            sym: 'SCR',
            name: 'Schichang Railway',
            logo: '1830/SCR',
            tokens: [0, 40, 100],
            coordinates: 'N12',
            color: '#282F1A',
          },
          {
            float_percent: 20,
            sym: 'CKR',
            name: 'Chengkun Railway',
            logo: '1830/CKR',
            tokens: [0, 40, 100],
            coordinates: 'O5',
            color: '#507EAE',
          },
          {
            float_percent: 20,
            sym: 'BCR',
            name: 'Baocheng Railway',
            logo: '1830/BCR',
            tokens: [0, 40, 100],
            coordinates: 'M3',
            color: '#94121D',
          },
          {
            float_percent: 20,
            sym: 'NXR',
            name: 'Ningxi Railway',
            logo: '1830/NXR',
            tokens: [0, 40, 100],
            coordinates: 'J6',
            color: '#A83B5B',
          },
          {
            float_percent: 20,
            sym: 'HKR',
            name: 'Hukun Railway',
            logo: '1830/HKR',
            tokens: [0, 40, 100],
            coordinates: 'K15',
            color: '#40743A',
          },
          {
            float_percent: 20,
            sym: 'NJR',
            name: 'Nanjiang Railway',
            logo: '1830/NJR',
            tokens: [0, 40, 100],
            coordinates: 'K13',
            color: '#452518',
          },
          {
            float_percent: 20,
            sym: 'QSR',
            name: 'Qinshen Railway',
            logo: '1830/QSR',
            tokens: [0, 40, 100],
            coordinates: 'D12',
            color: '#B3932C',
          },
          {
            float_percent: 20,
            sym: 'WNR',
            name: 'Wunan Railway',
            logo: '1830/WNR',
            tokens: [0, 40, 100],
            coordinates: 'L10',
            color: '#A4391F',
          },
        ].freeze
      end
    end
  end
end

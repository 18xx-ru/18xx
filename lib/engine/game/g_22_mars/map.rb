# frozen_string_literal: true

module Engine
  module Game
    module G22Mars
      module Map
        TILES = {
          '3' => 1,
        }.freeze

        # LOCATION_NAMES = {}.freeze

        HEXES = {
          white: {
            %w[C6 C8 C12 C14 D5 D7 D9 D11 D13 D15 E6 E8 E12 E14 G6 G8 G12 G14 H5 H7 H9 H11 H13 H15 I6 I8 I12 I14] => '',
          },
          gray: {
            ['A4'] => 'path=a:4,b:0,lanes:5',
            %w[A6 A8 A10 A12 A14 K6 K8 K10 K12 K14] => 'path=a:3,b:0,lanes:5',
            ['A16'] => 'path=a:3,b:5,lanes:5',
            ['B3'] => 'path=a:5,b:1,a_lane:4.0,b_lane:5.4;path=a:5,b:1,a_lane:4.1,b_lane:5.3;path=a:4,b:1,a_lane:3.0,b_lane:5.2;path=a:4,b:1,a_lane:3.1,b_lane:5.1;path=a:4,b:1,a_lane:3.2,b_lane:5.0',
            ['B5'] => 'path=a:5,b:4,b_lane:4.0;path=a:0,b:4,a_lane:4.3,b_lane:4.1;path=a:0,b:4,a_lane:4.2,b_lane:4.2;path=a:0,b:4,a_lane:4.1,b_lane:4.3',
            ['B7'] => 'path=a:4,b:3,b_lane:4.0;path=a:5,b:3,b_lane:4.1;path=a:0,b:3,b_lane:4.2',
            ['B9'] => 'path=a:4,b:3',
            ['B11'] => 'path=a:0,b:5',
            ['B13'] => 'path=a:5,b:0,b_lane:4.3;path=a:4,b:0,b_lane:4.2;path=a:3,b:0,b_lane:4.1',
            ['B15'] => 'path=a:4,b:5,b_lane:4.3;path=a:3,b:5,a_lane:4.0,b_lane:4.2;path=a:3,b:5,a_lane:4.1,b_lane:4.1;path=a:3,b:5,a_lane:4.2,b_lane:4.0',
            ['B17'] => 'path=a:4,b:2,a_lane:4.3,b_lane:5.0;path=a:4,b:2,a_lane:4.2,b_lane:5.1;path=a:5,b:2,a_lane:3.2,b_lane:5.2;path=a:5,b:2,a_lane:3.1,b_lane:5.3;path=a:5,b:2,a_lane:3.0,b_lane:5.4',
            ['C2'] => 'path=a:5,b:1,lanes:3',
            ['C4'] => 'path=a:1,b:4,lanes:4;path=a:0,b:2,b_lane:4.3;path=a:5,b:2,b_lane:4.2',
            %w[C10 G10] => 'path=a:0,b:3;path=a:4,b:5',
            ['C16'] => 'path=a:2,b:5,lanes:4;path=a:3,b:1,b_lane:4.0;path=a:4,b:1,b_lane:4.1;',
            ['C18'] => 'path=a:4,b:2,lanes:3',
            ['D1', 'H1'] => '',
            ['D3'] => 'path=a:1,b:4,lanes:4;path=a:0,b:2,b_lane:3.2;path=a:5,a_lane:2.0,b:2,b_lane:3.1;path=a:5,a_lane:2.1,b:2,b_lane:3.0',
            ['D17'] => 'path=a:2,b:5,lanes:4;path=a:3,b:1,b_lane:3.0;path=a:4,b:1,a_lane:2.1,b_lane:3.1;path=a:4,b:1,a_lane:2.0,b_lane:3.2',
            ['D19'] => '',
            ['E2'] => 'path=a:1,b:4,lanes:4',
            ['E4'] => 'path=a:1,b:2,b_lane:2.1;path=a:0,b:2,b_lane:2.0',
            %w[E10 I10] => 'path=a:0,b:3;path=a:1,b:2',
            ['E16'] => 'path=a:2,b:1,b_lane:2.0;path=a:3,b:1,b_lane:2.1',
            ['E18'] => 'path=a:2,b:5,lanes:4',
            ['F1'] => 'path=a:1,b:5,lanes:4',
            ['F3'] => '',
            %w[F5 F11] => 'path=a:1,b:5',
            %w[F7 F13] => 'path=a:2,b:4;path=a:1,b:5',
            %w[F9 F15] => 'path=a:2,b:4',
            ['F17'] => '',
            ['F19'] => 'path=a:2,b:4,lanes:4',
            ['G2'] => 'path=a:2,b:5,lanes:4',
            ['G4'] => 'path=a:0,b:4,b_lane:2.1;path=a:5,b:4,b_lane:2.0',
            ['G16'] => 'path=a:3,b:5,b_lane:2.0;path=a:4,b:5,b_lane:2.1',
            ['G18'] => 'path=a:1,b:4,lanes:4',
            ['H3'] => 'path=a:2,b:5,lanes:4;path=a:0,b:4,b_lane:3.0;path=a:1,b:4,a_lane:2.1,b_lane:3.1;path=a:1,b:4,a_lane:2.0,b_lane:3.2',
            ['H17'] => 'path=a:1,b:4,lanes:4;path=a:2,b:5,a_lane:2.1,b_lane:3.0;path=a:2,b:5,a_lane:2.0,b_lane:3.1;path=a:3,b:5,b_lane:3.2;',
            ['H19'] => '',
            ['I2'] => 'path=a:5,b:1,lanes:3',
            ['I4'] => 'path=a:2,b:5,lanes:4;path=a:1,b:4,b_lane:4.1;path=a:0,b:4,b_lane:4.0',
            ['I16'] => 'path=a:1,b:4,lanes:4;path=a:2,b:5,b_lane:4.2;path=a:3,b:5,b_lane:4.3',
            ['I18'] => 'path=a:4,b:2,lanes:3',
            %w[J13] => '',
            ['J3'] => 'path=a:1,b:5,a_lane:4.3,b_lane:5.0;path=a:1,b:5,a_lane:4.2,b_lane:5.1;path=a:2,b:5,a_lane:3.2,b_lane:5.2;path=a:2,b:5,a_lane:3.1,b_lane:5.3;path=a:2,b:5,a_lane:3.0,b_lane:5.4',
            ['J5'] => 'path=a:1,b:2,b_lane:4.3;path=a:0,b:2,a_lane:3.0,b_lane:4.2;path=a:0,b:2,a_lane:3.1,b_lane:4.1;path=a:0,b:2,a_lane:3.2,b_lane:4.0',
            ['J7'] => 'path=a:2,b:3,b_lane:3.2;path=a:1,b:3,b_lane:3.1;path=a:0,b:3,b_lane:3.0;',
            ['J9'] => 'path=a:2,b:3',
            ['J11'] => 'path=a:1,b:0',
            ['J13'] => 'path=a:1,b:0,b_lane:3.0;path=a:2,b:0,b_lane:3.1;path=a:3,b:0,b_lane:3.2;',
            ['J15'] => 'path=a:2,b:1,b_lane:4.0;path=a:3,b:1,a_lane:3.2,b_lane:4.1;path=a:3,b:1,a_lane:3.1,b_lane:4.2;path=a:3,b:1,a_lane:3.0,b_lane:4.3',
            ['J17'] => 'path=a:1,b:4,a_lane:3.2,b_lane:5.0;path=a:1,b:4,a_lane:3.1,b_lane:5.1;path=a:1,b:4,a_lane:3.0,b_lane:5.2;path=a:2,b:4,a_lane:4.1,b_lane:5.3;path=a:2,b:4,a_lane:4.0,b_lane:5.4',
            ['K4'] => 'path=a:2,b:0,lanes:5',
            ['K16'] => 'path=a:3,b:1,lanes:5',
          },
        }.freeze

        LAYOUT = :flat

      end
    end
  end
end

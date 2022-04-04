require 'json'
require 'yajl'

namespace :yahoo_import do
  task :players => [:environment] do
    def parse_players(parser, json)
      failures = []
      parser.parse(json)["free agents"].each do |player_data|
        if player = Player.find_by(full_name: player_data["name"]["full"]) || secondary_lookup(player_data)
            player.update_from_yahoo_data!(player_data) 
        else
          puts "Lookup failed for #{player_data["name"]["full"]}"
          failures << player_data
        end
      end
      puts "Updated #{Player.where('yahoo_player_id IS NOT NULL').count} players"
      if failures.count > 0
        puts "Failed to find #{failures.length} players"
        puts "Failed players: #{failures}"
      end
    end

    def secondary_lookup(player_data)
      puts "Attempting secondary lookup"
      Player.find_by(first_name: player_data["name"]["ascii_first"], last_name: player_data["name"]["ascii_last"])
    end

    def create_data
      json = File.new('public/allMyData.json', 'r')
      parser = Yajl::Parser.new
      parse_players(parser, json)
    end

    create_data
  end
end

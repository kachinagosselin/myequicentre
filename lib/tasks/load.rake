namespace :load do

  ZIP_CODE_DATA_URL = 'http://www.census.gov/tiger/tms/gazetteer/zips.txt'

  # Swiped from ActiveRecord migrations.rb
  def announce(message)
    length = [0, 75 - message.length].max
    puts "== %s %s" % [message, "=" * length]
  end

  desc "Loads zip codes from #{ZIP_CODE_DATA_URL}"
  task :zip_codes => :environment do
    begin
      time = Benchmark.measure do      
        require 'csv' 
        require 'open-uri'
        CSV.parse(open('/Users/kachinagosselin/Documents/zipcode/zipcode.csv').read) do |row|
          # Connascence of Position, Jim Weirich forgive me!
          zip = Zip.create!(
            :code => row[0],
            :state => row[2],
            :city => row[1],
            :lat => row[3],
            :lon => row[4])
          puts "%20s, %2s, %5s" % [zip.city, zip.state, zip.code]
        end
      end
      announce "Loaded %5d zip codes in (%2dm %2.0fs)" % [Zip.count, *time.real.divmod(60)]
    rescue LoadError
      puts "This rake task requires fastercsv.  To install, run this command:\n\n  sudo gem install fastercsv\n\n"
    end
  end

end
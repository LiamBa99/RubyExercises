require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'time'
require 'date'

def clean_phonenumber(phone_number)
    alpha = ['1','2','3','4','5','6','7','8','9','0']
    phone = []
    phone_number = phone_number.to_s

    if phone_number.length == 11 && phone_number[0] = '1'
        phone_number = phone_number[1..11]
    elsif phone_number.length == 10 && phone_number[0] != '1'
        phone_number.split('').each { |c|
            if alpha.include?(c) == true
                phone.push(c)
            end
        }
        phone_number = phone.join('')
    elsif phone_number.length > 11
        phone_number.split('').each { |c|
            if alpha.include?(c) == true
                phone.push(c)
            end
        }
        phone_number = phone.join('')
    else
        phone_number = "bad number"
    end
    phone_number
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hour_tally_hash = Hash.new(0)
day_tally_hash = Hash.new(0)

contents.each do |row|
    year = "2"
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
    phone_number = clean_phonenumber(row[:homephone])
    reg_time = row[:regdate][-5..-1]
    reg_day = row[:regdate]
    reg_day = row[:regdate].split(' ')[0]
    reg_day = Date.strptime(reg_day, "%m/%d/%y")
    day_tally_hash[reg_day.wday] += 1


    hour_tally_hash[Time.parse(reg_time).hour] += 1
    


  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  #save_thank_you_letter(id,form_letter)
end

puts hour_tally_hash
puts day_tally_hash
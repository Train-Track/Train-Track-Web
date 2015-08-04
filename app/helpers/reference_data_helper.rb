module ReferenceDataHelper

  # Updating the Reference Data
  #
  # UK National Rail Stations:
  #   Download http://www.dft.gov.uk/NaPTAN/snapshot/NaPTANcsv.zip and extract RailReferences.csv
  #   ReferenceDataHelper.update_rail_naptan
  # TfL Stations:
  #   Download https://api.tfl.gov.uk/StopPoint/Mode/tube,tflrail,dlr,overground to naptan.json
  #   ReferenceDataHelper.update_tube_naptan
  # National Rail Train Operators and National Rail Station Operators:
  #   Download ftp://datafeeds.nationalrail.co.uk/ to national_rail_reference_data.xml
  #   ReferenceDataHelper.update_reference_data
  # Timing Points:
  #   Download http://datafeeds.networkrail.co.uk/ntrod/SupportingFileAuthenticate?type=CORPUS to CORPUSExtract.json
  #   ReferenceDataHelper.update_corpus
  # Station and Operator Twitter:
  #  Manually managed files national_rail_stations_twitter.csv and operators_twitter.csv
  #  ReferenceDataHelper.update_twitter


  # Constants from Appendix 1 of CIF Specification
  # http://www.atoc.org/clientfiles/files/RSPS5004%20v27.pdf
  ACTIVITY_CODES = {
    "A" => "Stops or shunts for other trains to pass",
    "AE" => "Attach/detach assisting locomotive",
    "BL" => "Stops for banking locomotive",
    "C" => "Stops to change trainmen",
    "D" => "Stops to set down passengers",
    "-D" => "Stops to detach vehicles",
    "E" => "Stops for examination",
    "K" => "Passenger count point",
    "KC" => "Ticket collection and examination point",
    "KE" => "Ticket examination point",
    "KF" => "Ticket Examination Point, 1st Class only",
    "KS" => "Selective Ticket Examination Point",
    "L" => "Stops to change locomotives",
    "N" => "Stop not advertised",
    "OP" => "Stops for other operating reasons",
    "OR" => "Train Locomotive on rear",
    "PR" => "Propelling between points shown",
    "R" => "Stops when required",
    "RM" => "Reversing movement, or driver changes ends",
    "RR" => "Stops for locomotive to run round train",
    "S" => "Stops for railway personnel only",
    "T" => "Stops to take up and set down passengers",
    "-T" => "Stops to attach and detach vehicles",
    "TB" => "Train begins (Origin)",
    "TF" => "Train finishes (Destination)",
    "TS" => "Detail Consist for TOPS Direct requested by EWS",
    "TW" => "Stops (or at pass) for tablet, staff or token.",
    "U" => "Stops to take up passengers",
    "-U" => "Stops to attach vehicles",
    "W" => "Stops for watering of coaches",
    "X" => "Passes another train at crossing point on single line"
  }


  STATUS_CODES = {
    "B" => "Bus (Permanent).",
    "F" => "Freight (Permanent - WTT).",
    "P" => "Passenger & Parcels (Permanent - WTT).",
    "S" => "Ship (Permanent).",
    "T" => "Trip (Permanent)."
  }


  LATE_RUNNING_CODES = {
    "100" => "This train has been delayed by a broken down train",
    "101" => "This train has been delayed by a delay on a previous journey",
    "102" => "This train has been delayed by a derailed train",
    "104" => "This train has been delayed by a fire at a station",
    "105" => "This train has been delayed by a fire at a station earlier",
    "106" => "This train has been delayed by a landslip",
    "107" => "This train has been delayed by a line-side fire",
    "108" => "This train has been delayed by a member of train crew being unavailable",
    "109" => "This train has been delayed by a passenger being taken ill",
    "110" => "This train has been delayed by a passenger having been taken ill earlier",
    "111" => "This train has been delayed by a person hit by a train",
    "112" => "This train has been delayed by a person hit by a train earlier",
    "113" => "This train has been delayed by a problem at a level crossing",
    "114" => "This train has been delayed by a problem currently under investigation",
    "115" => "This train has been delayed by a problem near the railway",
    "116" => "This train has been delayed by a problem with a river bridge",
    "117" => "This train has been delayed by a problem with line side equipment",
    "118" => "This train has been delayed by a security alert",
    "119" => "This train has been delayed by a train derailed earlier",
    "120" => "This train has been delayed by a train fault",
    "121" => "This train has been delayed by a train late from the depot",
    "122" => "This train has been delayed by a train late from the depot earlier",
    "123" => "This train has been delayed by a trespass incident",
    "124" => "This train has been delayed by a vehicle striking a bridge",
    "125" => "This train has been delayed by a vehicle striking a bridge earlier",
    "126" => "This train has been delayed by an earlier broken down train",
    "128" => "This train has been delayed by an earlier landslip",
    "129" => "This train has been delayed by an earlier line-side fire",
    "130" => "This train has been delayed by an earlier operating incident",
    "131" => "This train has been delayed by an earlier problem at a level crossing",
    "132" => "This train has been delayed by an earlier problem near the railway",
    "133" => "This train has been delayed by an earlier problem with a river bridge",
    "134" => "This train has been delayed by an earlier problem with line side equipment",
    "135" => "This train has been delayed by an earlier security alert",
    "136" => "This train has been delayed by an earlier train fault",
    "137" => "This train has been delayed by an earlier trespass incident",
    "138" => "This train has been delayed by an obstruction on the line",
    "139" => "This train has been delayed by an obstruction on the line earlier",
    "140" => "This train has been delayed by an operating incident",
    "141" => "This train has been delayed by an unusually large passenger flow",
    "142" => "This train has been delayed by an unusually large passenger flow earlier",
    "143" => "This train has been delayed by animals on the line",
    "144" => "This train has been delayed by animals on the line earlier",
    "145" => "This train has been delayed by congestion caused by earlier delays",
    "146" => "This train has been delayed by disruptive passengers",
    "147" => "This train has been delayed by disruptive passengers earlier",
    "148" => "This train has been delayed by earlier electrical supply problems",
    "149" => "This train has been delayed by earlier emergency engineering works",
    "150" => "This train has been delayed by earlier industrial action",
    "151" => "This train has been delayed by earlier overhead wire problems",
    "152" => "This train has been delayed by earlier over-running engineering works",
    "153" => "This train has been delayed by earlier signalling problems",
    "154" => "This train has been delayed by earlier vandalism",
    "155" => "This train has been delayed by electrical supply problems",
    "156" => "This train has been delayed by emergency engineering works",
    "157" => "This train has been delayed by emergency services dealing with a prior incident",
    "158" => "This train has been delayed by emergency services dealing with an incident",
    "159" => "This train has been delayed by fire alarms sounding at a station",
    "160" => "This train has been delayed by fire alarms sounding earlier at a station",
    "161" => "This train has been delayed by flooding",
    "162" => "This train has been delayed by flooding earlier",
    "163" => "This train has been delayed by fog",
    "164" => "This train has been delayed by fog earlier",
    "165" => "This train has been delayed by high winds",
    "166" => "This train has been delayed by high winds earlier",
    "167" => "This train has been delayed by industrial action",
    "168" => "This train has been delayed by lightning having damaged equipment",
    "169" => "This train has been delayed by overhead wire problems",
    "170" => "This train has been delayed by over-running engineering works",
    "171" => "This train has been delayed by passengers transferring between trains",
    "172" => "This train has been delayed by passengers transferring between trains earlier",
    "173" => "This train has been delayed by poor rail conditions",
    "174" => "This train has been delayed by poor rail conditions earlier",
    "175" => "This train has been delayed by poor weather conditions",
    "176" => "This train has been delayed by poor weather conditions earlier",
    "177" => "This train has been delayed by safety checks being made",
    "178" => "This train has been delayed by safety checks having been made earlier",
    "179" => "This train has been delayed by signalling problems",
    "180" => "This train has been delayed by snow",
    "181" => "This train has been delayed by snow earlier",
    "182" => "This train has been delayed by speed restrictions having been imposed",
    "183" => "This train has been delayed by train crew having been unavailable earlier",
    "184" => "This train has been delayed by vandalism",
    "185" => "This train has been delayed by waiting earlier for a train crew member",
    "186" => "This train has been delayed by waiting for a train crew member",
    "187" => "This train has been delayed by engineering works"
  }


  CANCELLATION_CODES = {
    "100" => "This train has been cancelled because of a broken down train",
    "101" => "This train has been cancelled because of a delay on a previous journey",
    "102" => "This train has been cancelled because of a derailed train",
    "104" => "This train has been cancelled because of a fire at a station",
    "105" => "This train has been cancelled because of a fire at a station earlier",
    "106" => "This train has been cancelled anbecause of a landslip",
    "107" => "This train has been ccelled because of a line-side fire",
    "108" => "This train has been cancelled because of a member of train crew being unavailable",
    "109" => "This train has been cancelled because of a passenger being taken ill",
    "110" => "This train has been cancelled because of a passenger having been taken ill earlier",
    "111" => "This train has been cancelled because of a person hit by a train",
    "112" => "This train has been cancelled because of a person hit by a train earlier",
    "113" => "This train has been cancelled because of a problem at a level crossing",
    "114" => "This train has been cancelled because of a problem currently under investigation",
    "115" => "This train has been cancelled because of a problem near the railway",
    "116" => "This train has been cancelled because of a problem with a river bridge",
    "117" => "This train has been cancelled because of a problem with line side equipment",
    "118" => "This train has been cancelled because of a security alert",
    "119" => "This train has been cancelled because of a train derailed earlier",
    "120" => "This train has been cancelled because of a train fault",
    "121" => "This train has been cancelled because of a train late from the depot",
    "122" => "This train has been cancelled because of a train late from the depot earlier",
    "123" => "This train has been cancelled because of a trespass incident",
    "124" => "This train has been cancelled because of a vehicle striking a bridge",
    "125" => "This train has been cancelled because of a vehicle striking a bridge earlier",
    "126" => "This train has been cancelled because of an earlier broken down train",
    "128" => "This train has been cancelled because of an earlier landslip",
    "129" => "This train has been cancelled because of an earlier line-side fire",
    "130" => "This train has been cancelled because of an earlier operating incident",
    "131" => "This train has been cancelled because of an earlier problem at a level crossing",
    "132" => "This train has been cancelled because of an earlier problem near the railway",
    "133" => "This train has been cancelled because of an earlier problem with a river bridge",
    "134" => "This train has been cancelled because of an earlier problem with line side equipment",
    "135" => "This train has been cancelled because of an earlier security alert",
    "136" => "This train has been cancelled because of an earlier train fault",
    "137" => "This train has been cancelled because of an earlier trespass incident",
    "138" => "This train has been cancelled because of an obstruction on the line",
    "139" => "This train has been cancelled because of an obstruction on the line earlier",
    "140" => "This train has been cancelled because of an operating incident",
    "141" => "This train has been cancelled because of an unusually large passenger flow",
    "142" => "This train has been cancelled because of an unusually large passenger flow earlier",
    "143" => "This train has been cancelled because of animals on the line",
    "144" => "This train has been cancelled because of animals on the line earlier",
    "145" => "This train has been cancelled because of congestion caused by earlier delays",
    "146" => "This train has been cancelled because of disruptive passengers",
    "147" => "This train has been cancelled because of disruptive passengers earlier",
    "148" => "This train has been cancelled because of earlier electrical supply problems",
    "149" => "This train has been cancelled because of earlier emergency engineering works",
    "150" => "This train has been cancelled because of earlier industrial action",
    "151" => "This train has been cancelled because of earlier overhead wire problems",
    "152" => "This train has been cancelled because of earlier over-running engineering works",
    "153" => "This train has been cancelled because of earlier signalling problems",
    "154" => "This train has been cancelled because of earlier vandalism",
    "155" => "This train has been cancelled because of electrical supply problems",
    "156" => "This train has been cancelled because of emergency engineering works",
    "157" => "This train has been cancelled because of emergency services dealing with a prior incident",
    "158" => "This train has been cancelled because of emergency services dealing with an incident",
    "159" => "This train has been cancelled because of fire alarms sounding at a station",
    "160" => "This train has been cancelled because of fire alarms sounding earlier at a station",
    "161" => "This train has been cancelled because of flooding",
    "162" => "This train has been cancelled because of flooding earlier",
    "163" => "This train has been cancelled because of fog",
    "164" => "This train has been cancelled because of fog earlier",
    "165" => "This train has been cancelled because of high winds",
    "166" => "This train has been cancelled because of high winds earlier",
    "167" => "This train has been cancelled because of industrial action",
    "168" => "This train has been cancelled because of lightning having damaged equipment",
    "169" => "This train has been cancelled because of overhead wire problems",
    "170" => "This train has been cancelled because of over-running engineering works",
    "171" => "This train has been cancelled because of passengers transferring between trains",
    "172" => "This train has been cancelled because of passengers transferring between trains earlier",
    "173" => "This train has been cancelled because of poor rail conditions",
    "174" => "This train has been cancelled because of poor rail conditions earlier",
    "175" => "This train has been cancelled because of poor weather conditions",
    "176" => "This train has been cancelled because of poor weather conditions earlier",
    "177" => "This train has been cancelled because of safety checks being made",
    "178" => "This train has been cancelled because of safety checks having been made earlier",
    "179" => "This train has been cancelled because of signalling problems",
    "180" => "This train has been cancelled because of snow",
    "181" => "This train has been cancelled because of snow earlier",
    "182" => "This train has been cancelled because of speed restrictions having been imposed",
    "183" => "This train has been cancelled because of train crew having been unavailable earlier",
    "184" => "This train has been cancelled because of vandalism",
    "185" => "This train has been cancelled because of waiting earlier for a train crew member",
    "186" => "This train has been cancelled because of waiting for a train crew member",
    "187" => "This train has been cancelled because of engineering works"
  }


  CATEGORY_CODES = {
    "OL" => "London Underground/Metro Service",
    "OU" => "Unadvertised Ordinary Passenger",
    "OO" => "Ordinary Passenger",
    "OS" => "Staff Train",
    "OW" => "Mixed",
    "XC" => "Channel Tunnel",
    "XD" => "Sleeper (Europe Night Services)",
    "XI" => "International",
    "XR" => "Motorail",
    "XU" => "Unadvertised Express",
    "XX" => "Express Passenger",
    "XZ" => "Sleeper (Domestic)",
    "BR" => "Bus – Replacement due to engineering work",
    "BS" => "Bus – WTT Service",
    "EE" => "Empty Coaching Stock (ECS)",
    "EL" => "ECS, London Underground/Metro Service",
    "ES" => "ECS & Staff",
    "JJ" => "Postal",
    "PM" => "Post Office Controlled Parcels",
    "PP" => "Parcels",
    "PV" => "Empty NPCCS",
    "DD" => "Departmental",
    "DH" => "Civil Engineer",
    "DI" => "Mechanical & Electrical Engineer",
    "DQ" => "Stores",
    "DT" => "Test",
    "DY" => "Signal & Telecommunications Engineer",
    "ZB" => "Locomotive & Brake Van",
    "ZZ" => "Light Locomotive",
    "J2" => "RfD Automotive (Components)",
    "H2" => "RfD Automotive (Vehicles)",
    "J3" => "RfD Edible Products (UK Contracts)",
    "J4" => "RfD Industrial Minerals (UK Contracts)",
    "J5" => "RfD Chemicals (UK Contracts)",
    "J6" => "RfD Building Materials (UK Contracts)",
    "J8" => "RfD General Merchandise (UK Contracts)",
    "H8" => "RfD European",
    "J9" => "RfD Freightliner (Contracts)",
    "H9" => "RfD Freightliner (Other)",
    "A0" => "Coal (Distributive)",
    "E0" => "Coal (Electricity) MGR",
    "B0" => "Coal (Other) and Nuclear",
    "B1" => "Metals",
    "B4" => "Aggregates",
    "B5" => "Domestic and Industrial Waste",
    "B6" => "Building Materials (TLF)",
    "B7" => "Petroleum Products",
    "H0" => "RfD European Channel Tunnel (Mixed Business)",
    "H1" => "RfD European Channel Tunnel Intermodal",
    "H3" => "RfD European Channel Tunnel Automotive",
    "H4" => "RfD European Channel Tunnel Contract Services",
    "H5" => "RfD European Channel Tunnel Haulmark",
    "H6" => "RfD European Channel Tunnel Joint Venture"
  }


  CALLING_POINT_TYPES = {
    "OR" => "Passenger Origin",
    "OPOR" => "Operational Origin",
    "IP" => "Passenger Calling Point",
    "OPIP" =>  "Operational Calling Point",
    "PP" => "Passing Point",
    "DT" => "Passenger Destination",
    "OPDT" => "Operational Destination"
  }


  # This populates UK Train Stations from RailReferences.csv from Naptan
  # RailReferences.csv in http://www.dft.gov.uk/NaPTAN/snapshot/NaPTANcsv.zip
  def self.update_rail_naptan
    File.readlines('reference/RailReferences.csv').each do |line|
      next if line.start_with? '"AtcoCode"'
      parts = line.split(",")
      crs = parts[2].gsub('"', '')
      name = parts[3].gsub('"', '').gsub(" Rail Station", "")
      naptan = parts[0].gsub('"', '')
      ll = [nil, nil]
      ll = BlueGeo.easting_northing_to_lat_lon(parts[6].to_i, parts[7].to_i)
      station_attributes = {
        name: name,
        crs: crs,
        underground: false,
        national_rail: true,
        lat: ll[0],
        lng: ll[1]
      }
      station = Station.where(rail_naptan: naptan).first_or_create
      Station.update(station.id, station_attributes)
    end
    return
  end


  # This populates Tfl Stations from naptan.json from TfL API
  # https://api.tfl.gov.uk/StopPoint/Mode/tube,tflrail,dlr,overground
  def self.update_tube_naptan
    json = JSON.parse(File.read('reference/naptan.json'))
    json.each do |entry|
      next if entry['stopType'] != "NaptanMetroStation"
      name = entry['commonName'].gsub(' Underground Station', '')
      naptan = entry['naptanId']
      lat = entry['lat']
      lng = entry['lon']
      number = entry['icsCode']
      zone = nil
      address = nil
      phone = nil
      facilities = {}
      entry['additionalProperties'].each do |property|
        zone = property["value"] if property['key'] == "Zone"
        address = property["value"] if property['key'] == "Address"
        phone = property["value"] if property['key'] == "PhoneNo"
        facilities[property['key']] = property["value"] if property["category"] == "Facility"
      end
      station_attributes = {
        name: name,
        address: address,
        phone: phone,
        number: number,
        underground: true,
        national_rail: false,
        underground_zones: zone,
        facilities: facilities.to_json,
        lat: lat,
        lng: lng
      }
      station = Station.where(underground_naptan: naptan).first_or_create
      Station.update(station.id, station_attributes)
    end
    return
  end


  # Create/Update Train Operators from National Rail Reference Data and link them to Stations
  # ftp://datafeeds.nationalrail.co.uk
  def self.update_reference_data
    xml = Nokogiri::XML(File.open('reference/national_rail_reference_data.xml'))

    xml.css('TocRef').each do |toc|
      code = toc.attr('code')
      name = toc.attr('tocname')

      # Not interested in things that we don't know the name of
      next if code.nil? or name.nil?

      attr = { code: code, name: name }
      operator = Operator.where(code: code).first
      if operator.nil?
        Operator.create(attr)
      else
        operator.update(attr)
      end
    end

    xml.css('LocationRef').each do |location|
      crs = location.attr('crs')
      operator_code = location.attr('toc')

      # Not interested if it's not a station with an operator defined
      next if crs.nil? or operator_code.nil?

      operator = Operator.where(code: operator_code).first
      if operator
        operator = Station.where(crs: crs).update_all(operator_id: operator.id)
      end
    end

    # All the TfL stations can have London Underground as operator
    operator = Operator.where(name: "London Underground").first
    Station.where(underground: true).update_all(operator_id: operator.id) if operator
    return
  end


  # This file is from Network Rail Data Feeds - it adds all timing points (tiplocs)
  # http://datafeeds.networkrail.co.uk/ntrod/SupportingFileAuthenticate?type=CORPUS
  def self.update_corpus
    timing_points = Array.new
    json = JSON.parse(File.read('reference/CORPUSExtract.json'))
    json["TIPLOCDATA"].each do |entry|
      code = entry["TIPLOC"].strip
      name = entry["NLCDESC"].strip
      stanox = entry["STANOX"].strip
      crs = entry["3ALPHA"].strip

      next if code.empty?
      stanox = nil if stanox.empty?
      if crs.empty?
        station_id = nil
      else
        station = Station.where("rail_naptan LIKE ?", "9100" + code).first
        station_id = station.id if station
      end
      timing_points << TimingPoint.where(code: code).first_or_create(name: name, station_id: station_id, stanox: stanox)
    end
    return
  end


  # This populates Train Station and Operators twitter accounts from static files
  # comma delimited national_rail_stations_twitter.csv and operators_twitter.csv
  def self.update_twitter
    File.readlines('reference/national_rail_stations_twitter.csv').each do |line|
      parts = line.split(",")
      next if parts.length < 2
      code = parts[0].strip
      twitter = parts[1].strip
      Station.where(crs: code).update_all(twitter: twitter)
    end
    File.readlines('reference/operators_twitter.csv').each do |line|
      parts = line.split(",")
      next if parts.length < 2
      code = parts[0].strip
      twitter = parts[1].strip
      Operator.where(code: code).update_all(twitter: twitter)
    end
    return
  end


  # This file is from National Rail FTP site and updates the timetables
  # ftp://datafeeds.nationalrail.co.uk
  def self.update_schedule
    Timetable.connection.execute("TRUNCATE timetables");
    TimetableCallingPoint.connection.execute("TRUNCATE timetable_calling_points");

    timetables = Array.new

    xml = Nokogiri::XML(File.open('reference/national_rail_schedule.xml'))
    xml.css('Journey').each do |journey|
      attr = Hash.new

      passenger_service = journey.attr('isPassengerSvc')
      if passenger_service == "false"
        next
      end

      operator = Operator.where(code: journey.attr('toc')).first
      if operator
        attr[:operator_id] = operator.id
      end

      attr[:rtti_id] = journey.attr('rid')
      attr[:train_id] = journey.attr('trainId')
      attr[:schedule_id] = journey.attr('uid')
      attr[:start_date] = journey.attr('ssd')
      attr[:train_type] = STATUS_CODES[journey.attr('status') || "P"]
      attr[:late_running_reason] = LATE_RUNNING_CODES[journey.css('lateRunningReason').text]
      attr[:cancellation_reason] = CANCELLATION_CODES[journey.css('cancelReason').text]
      attr[:train_category] = CATEGORY_CODES[journey.attr('trainCat') || "OO"]

      timetable = Timetable.create(attr)

      journey.children.each do |point|
        attr = Hash.new
        attr[:timetable_id] = timetable.id

        attr[:calling_point_type] = CALLING_POINT_TYPES[point.node_name]
        next unless attr[:calling_point_type]

        attr[:cancelled] = if ((point.attr('can') == "false") or point.attr('can').nil?) then false else true end
        attr[:tiploc_code] = point.attr('tpl')
        tp = TimingPoint.where(code: attr[:tiploc_code]).first
        attr[:timing_point_id] = tp.id if tp
        attr[:station_id] = tp.station_id if tp
        attr[:public_time_arrival] = point.attr('pta')
        attr[:public_time_departure] = point.attr('ptd')
        attr[:working_time_arrival] = point.attr('wta')
        attr[:working_time_departure] = point.attr('wtd')
        attr[:working_time_passing] = point.attr('wtp')
        attr[:platform] = point.attr('plat')

        activitiesJSON = Array.new
        activities = point.attr('act')
        ACTIVITY_CODES.to_a.reverse.to_h.each do |key, value|
          if activities and activities.include? key
            activities = activities.gsub(key, '')
            activitiesJSON << { key => value }
          end
        end
        attr[:activities] = activitiesJSON.to_json

        activitiesJSON = Array.new
        activities = point.attr('planAct') || point.attr('act')
        ACTIVITY_CODES.to_a.reverse.to_h.each do |key, value|
          if activities and activities.include? key
            activities = activities.gsub(key, '')
            activitiesJSON << { key => value }
          end
        end
        attr[:planned_activities] = activitiesJSON.to_json

        TimetableCallingPoint.create(attr)
      end
    end
  end


  def self.update_train_station_distances
    problems = []
    File.open("reference/Tube Station Distances.csv", "r") do |f|
      f.each_line do |line|
        parts = line.split(',')

        line = Tube::Line.where("name LIKE ?", parts[0].gsub('&', 'and')).first
        if line.nil?
          problems << "Cannot find line: #{parts[0]}"
          next
        end

        [2,3].each do |i|

          parts[i].gsub!("SHEPHERDS BUSH", "Shepherd's Bush")
          parts[i].gsub!("QUEENS PARK", "Queen's Park")
          parts[i].gsub!("KINGS CROSS", "King's Cross St. Pancras")
          parts[i].gsub!("REGENTS PARK", "Regent's Park")
          parts[i].gsub!("ST PAULS", "St. Paul's")
          parts[i].gsub!("ST JOHNS WOOD", "St. John's Wood")
          parts[i].gsub!("HEATHROW TERMINAL FOUR", "Heathrow Terminal 4")
          parts[i].gsub!("HEATHROW 123", "Heathrow Terminals 1, 2, 3")
          parts[i].gsub!("EARLS COURT", "Earl's Court")
          parts[i].gsub!("King's Cross St. Pancras ST PANCRAS", "King's Cross St. Pancras")
          parts[i].gsub!("BAKER STREET (METROPOLITAN)", "Baker Street")
          parts[i].gsub!("BAKER STREET (MET)", "Baker Street")
          parts[i].gsub!("BAKER STREET (CIRCLE)", "Baker Street")
          parts[i].gsub!("KENNINGTON (CITY)", "Kennington")
          parts[i].gsub!("KENNINGTON (CX)", "Kennington")
          parts[i].gsub!("EUSTON (CITY)", "Euston")
          parts[i].gsub!("EUSTON (CX)", "Euston")
          parts[i].gsub!("HIGHBURY", "Highbury & Islington")
          parts[i].gsub!("PADDINGTON (CIRCLE)", "Paddington")
          parts[i].gsub!("PADDINGTON (Dis)", "Paddington")
          parts[i].gsub!("BROMLEY BY BOW", "Bromley-By-Bow")
          parts[i].gsub!("WALTHAMSTOW", "Walthamstow Central")
          parts[i].gsub!("HAMMERSMITH (DISTRICT)", "Hammersmith")
          parts[i].gsub!("FINCHLEY CENTRAL (HB)", "Finchley Central")

          if parts[i].upcase == "EDGWARE ROAD"
            parts[i] = "EDGWARE ROAD " + parts[0].upcase
          end

        end

        from = Station.where("name LIKE ?", parts[2]).first
        if from.nil?
          problems << "Cannot find from: #{parts[2]}"
          next
        end

        to = Station.where("name LIKE ?", parts[3]).first
        if to.nil?
          problems << "Cannot find to: #{parts[3]}"
          next
        end

        station_tube_line = {
          tube_line_id: line.id,
          direction: parts[1],
          from_id: from.id,
          to_id: to.id,
          distance: (parts[4].to_f * 1000).round,
          running_time: (parts[5].to_f * 60).round
        }
        Tube::StationTubeLine.where(station_tube_line).first_or_create
      end
    end
    return problems
  end

end

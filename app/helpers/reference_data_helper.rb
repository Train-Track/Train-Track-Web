module ReferenceDataHelper

  #Constants from Appendix 1 of CIF Specification
  #http://www.atoc.org/clientfiles/files/RSPS5004%20v27.pdf

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


  #This file is from Network Rail Data Feeds
  #http://datafeeds.networkrail.co.uk/ntrod/SupportingFileAuthenticate?type=CORPUS
  def self.update_corpus
    timing_points = Array.new    
    json = JSON.parse(File.read('CORPUSExtract.json'))
    json["TIPLOCDATA"].each do |entry|
      unless entry["TIPLOC"].strip.empty?
        unless entry["3ALPHA"].strip.empty?
          station = Station.where(crs: entry["3ALPHA"]).first
          station_id = station.id if station
        end
        timing_points << TimingPoint.where(code: entry["TIPLOC"]).first_or_create(name: entry["NLCDESC"], station_id: station_id)
      end
    end
    return timing_points
  end


  #This file is from National Rail FTP site
  def self.update_schedule
    schedules = Array.new
    xml = Nokogiri::XML(File.open('national_rail_schedule.xml'))
    xml.css('Journey').each do |journey|
      schedule = Hash.new

      passenger_service = journey.attr('isPassengerSvc')
      if passenger_service == "false"
        next
      end

      operator = Operator.where(code: journey.attr('toc')).first
      if operator
        schedule[:operator_id] = operator.id
      end

      schedule[:rtti_id] = journey.attr('rid')
      schedule[:train_id] = journey.attr('trainId')
      schedule[:schedule_id] = journey.attr('uid')
      schedule[:type] = STATUS_CODES[journey.attr('status') || "P"]
      schedule[:late_running_reason] = LATE_RUNNING_CODES[journey.css('lateRunningReason').text]
      schedule[:cancellation_reason] = CANCELLATION_CODES[journey.css('cancelReason').text]
      schedule[:train_category] = CATEGORY_CODES[journey.attr('trainCat') || "OO"]

      schedule[:calling_points] = Array.new
      journey.children.each do |point|
        calling_point = Hash.new
        
        if point.node_name == "OR"
          calling_point[:type] = "Passenger Origin"
        elsif point.node_name == "OPOR"
          calling_point[:type] = "Operational Origin"
        elsif point.node_name == "IP"
          calling_point[:type] = "Passenger Calling Point"
        elsif point.node_name == "OPIP"
          calling_point[:type] = "Operational Calling Point"
        elsif point.node_name == "PP"
          calling_point[:type] = "Passing Point"
        elsif point.node_name == "DT"
          calling_point[:type] = "Passenger Destination"
        elsif point.node_name == "OPDT"
          calling_point[:type] = "Operational Destination"
        else
          next
        end

        calling_point[:cancelled] = if ((point.attr('can') == "false") or point.attr('can').nil?) then false else true end
        calling_point[:tiploc_code] = point.attr('tpl')
        calling_point[:timing_point] = TimingPoint.where(code: calling_point[:tiploc_code]).first
        calling_point[:station] = calling_point[:timing_point].station if calling_point[:timing_point]
        calling_point[:pta] = point.attr('pta')
        calling_point[:ptd] = point.attr('ptd')
        calling_point[:wta] = point.attr('wta')
        calling_point[:wtd] = point.attr('wtd')
        calling_point[:wtp] = point.attr('wtp')
        calling_point[:platform] = point.attr('plat')

        calling_point[:activities] = Array.new
        activities = point.attr('act')
        ACTIVITY_CODES.to_a.reverse.to_h.each do |key, value|
          if activities and activities.include? key
            activities = activities.gsub(key, '')
            calling_point[:activities] << { key => value }
          end
        end

        calling_point[:planned_activities] = Array.new
        activities = point.attr('planAct') || point.attr('act')
        ACTIVITY_CODES.to_a.reverse.to_h.each do |key, value|
          if activities and activities.include? key
            activities = activities.gsub(key, '')
            calling_point[:planned_activities] << { key => value }
          end
        end

        schedule[:calling_points] << calling_point
      end

      schedules << schedule
    end
    return schedules
  end


  #This file is from National Rail FTP site
  def self.update_reference_data
    xml = Nokogiri::XML(File.open('national_rail_reference_data.xml'))
    xml.css('LocationRef').each do |location|
      ReferenceDataHelper.update_location location
    end
    xml.css('TocRef').each do |toc|
      ReferenceDataHelper.update_operator toc
    end
  end


  def self.update_operator toc
    attr = Hash.new

    code = toc.attr('code')
    if code.nil?
      return
    else
      attr[:code] = code
    end

    name = toc.attr('tocname')
    if name.nil?
      return
    else
      attr[:name] = name
    end

    operator = Operator.where(code: code).first
    if operator.nil?
      Operator.create(attr)
    else
      operator.update(attr)
    end
    return operator
  end


  def self.update_location location
    attr = { national_rail: true }

    crs = location.attr('crs')
    if crs.nil?
      return
    else
      attr[:crs] = crs
    end

    name = location.attr('locname')
    if name.nil? or name.include? '(Bus)'
      return
    else
      attr[:name] = name
    end

    tiploc_code = location.attr('tpl')
    if tiploc_code.nil? or tiploc_code == name
      return
    elsif tiploc_code
      attr[:tiploc_code] = tiploc_code
    end

    operator_code = location.attr('toc')
    if operator_code
      operator = Operator.where(code: operator_code).first
      if operator
        attr[:operator_id] = operator.id
      end
    end

    station = Station.where(crs: crs, national_rail: true).first
    if station.nil?
      # Not going to create it yet because it prob is not a UK train station
      #Station.create(attr)
    else
      station.update(attr)
    end
  end


end

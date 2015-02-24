require 'rest_client'
module NationalRailApiHelper

  DEBUG = true
  URL = 'https://lite.realtime.nationalrail.co.uk/OpenLDBWS/ldb6.asmx'
  ACCESS_TOKEN = ENV['TRAINS_ACCESS_TOKEN']
  SOAP_HEADERS = '<?xml version="1.0"?><SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://thalesgroup.com/RTTI/2014-02-20/ldb/" xmlns:ns2="http://thalesgroup.com/RTTI/2010-11-01/ldb/commontypes"><SOAP-ENV:Header><ns2:AccessToken><ns2:TokenValue>' + ACCESS_TOKEN + '</ns2:TokenValue></ns2:AccessToken></SOAP-ENV:Header>'

  def self.get_departure_board crs    
    soap_body = '<SOAP-ENV:Body><ns1:GetDepartureBoardRequest><ns1:crs>' + crs + '</ns1:crs></ns1:GetDepartureBoardRequest></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    begin
      if DEBUG
        xml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><GetDepartureBoardResponse xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/"><GetStationBoardResult><generatedAt xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">2015-02-24T00:45:29.9411531+00:00</generatedAt><locationName xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">Manchester Piccadilly</locationName><crs xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">MAN</crs><nrccMessages xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types"><message xmlns="http://thalesgroup.com/RTTI/2012-01-13/ldb/types">&lt;P&gt;Buses are replacing trains between Leamington Spa and Banbury until further notice. More details can be found in &lt;A href="http://nationalrail.co.uk/service_disruptions/90845.aspx"&gt;Latest Travel News.&lt;/A&gt;&lt;/P&gt;</message><message xmlns="http://thalesgroup.com/RTTI/2012-01-13/ldb/types">Trains between Bristol Parkway and Swindon / Gloucester are being delayed by up to 30 minutes. more information can be found in &lt;A href="http://nationalrail.co.uk/service_disruptions/92015.aspx"&gt;latest travel news.&lt;/A&gt;</message></nrccMessages><platformAvailable xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">true</platformAvailable><trainServices xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types"><service><origin><location><locationName>Newcastle</locationName><crs>NCL</crs><via /><futureChangeTo /></location></origin><destination><location><locationName>Manchester Airport</locationName><crs>MIA</crs><via /><futureChangeTo /></location></destination><std>00:41</std><etd>00:45</etd><platform>13</platform><operator>First TransPennine Express</operator><operatorCode>TP</operatorCode><serviceID>IpMJESNNWDdU0TrI/MBJJQ==</serviceID></service><service><origin><location><locationName>Manchester Airport</locationName><crs>MIA</crs><via /><futureChangeTo /></location></origin><destination><location><locationName>York</locationName><crs>YRK</crs><via /><futureChangeTo /></location></destination><std>00:53</std><etd>On time</etd><platform>14</platform><operator>First TransPennine Express</operator><operatorCode>TP</operatorCode><serviceID>ddBpYdC+F7J68e3Jx0kMeQ==</serviceID></service></trainServices></GetStationBoardResult></GetDepartureBoardResponse></soap:Body></soap:Envelope>'
        xml = Nokogiri::XML(xml)
      else
        response = RestClient.post URL, SOAP_HEADERS + soap_body, content_type: 'text/xml'
        xml = Nokogiri::XML(response.body)
      end
    rescue => e
      return "Error"
    end
    xml.remove_namespaces!
    departure_board = StationBoard.new
    departure_board.parse(xml)
    return departure_board
  end

  def self.get_arrival_board crs    
    soap_body = '<SOAP-ENV:Body><ns1:GetArrivalBoardRequest><ns1:crs>' + crs + '</ns1:crs></ns1:GetArrivalBoardRequest></SOAP-ENV:Body></SOAP-ENV:Envelope>'
    begin
      if DEBUG
        xml = '<?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><GetDepartureBoardResponse xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/"><GetStationBoardResult><generatedAt xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">2015-02-24T00:45:29.9411531+00:00</generatedAt><locationName xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">Manchester Piccadilly</locationName><crs xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">MAN</crs><nrccMessages xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types"><message xmlns="http://thalesgroup.com/RTTI/2012-01-13/ldb/types">&lt;P&gt;Buses are replacing trains between Leamington Spa and Banbury until further notice. More details can be found in &lt;A href="http://nationalrail.co.uk/service_disruptions/90845.aspx"&gt;Latest Travel News.&lt;/A&gt;&lt;/P&gt;</message><message xmlns="http://thalesgroup.com/RTTI/2012-01-13/ldb/types">Trains between Bristol Parkway and Swindon / Gloucester are being delayed by up to 30 minutes. more information can be found in &lt;A href="http://nationalrail.co.uk/service_disruptions/92015.aspx"&gt;latest travel news.&lt;/A&gt;</message></nrccMessages><platformAvailable xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types">true</platformAvailable><trainServices xmlns="http://thalesgroup.com/RTTI/2014-02-20/ldb/types"><service><origin><location><locationName>Newcastle</locationName><crs>NCL</crs><via /><futureChangeTo /></location></origin><destination><location><locationName>Manchester Airport</locationName><crs>MIA</crs><via /><futureChangeTo /></location></destination><std>00:41</std><etd>00:45</etd><platform>13</platform><operator>First TransPennine Express</operator><operatorCode>TP</operatorCode><serviceID>IpMJESNNWDdU0TrI/MBJJQ==</serviceID></service><service><origin><location><locationName>Manchester Airport</locationName><crs>MIA</crs><via /><futureChangeTo /></location></origin><destination><location><locationName>York</locationName><crs>YRK</crs><via /><futureChangeTo /></location></destination><std>00:53</std><etd>On time</etd><platform>14</platform><operator>First TransPennine Express</operator><operatorCode>TP</operatorCode><serviceID>ddBpYdC+F7J68e3Jx0kMeQ==</serviceID></service></trainServices></GetStationBoardResult></GetDepartureBoardResponse></soap:Body></soap:Envelope>'
        xml = Nokogiri::XML(xml)
      else
        response = RestClient.post URL, SOAP_HEADERS + soap_body, content_type: 'text/xml'
        xml = Nokogiri::XML(response.body)
      end
    rescue => e
      return "Error"
    end
    xml.remove_namespaces!
    arrival_board = StationBoard.new
    arrival_board.parse(xml)
    return arrival_board
  end

end

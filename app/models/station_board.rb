class StationBoard
  attr_accessor :nrcc_messages, :train_services, :tube_lines

  def initialize
    @nrcc_messages = []
    @train_services = []
    @tube_lines = []
  end

  def parse xml
    #self.platform_available = xml.css('platformAvailable').text == "true"
    #self.services_available = xml.css('areServicesAvailable').text == "" || xml.css('areServicesAvailable').text == "true"
    xml.css('nrccMessages').children.each do |message|
      self.nrcc_messages << ActionView::Base.full_sanitizer.sanitize(message.text)
    end
    xml.css('trainServices').children.each do |train_service|
      service_item = ServiceItem.new
      service_item.parse(train_service)
      self.train_services << service_item
    end
  end

end

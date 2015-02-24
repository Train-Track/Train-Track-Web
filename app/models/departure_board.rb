class DepartureBoard
  attr_reader :nrcc_messages, :train_services
  attr_writer :nrcc_messages, :train_services

  def initialize
    @nrcc_messages = []
    @train_services = []
  end

  def parse xml
    xml.css('nrccMessages').children.each do |message|
      self.nrcc_messages << message.text.html_safe
    end
    xml.css('trainServices').children.each do |train_service|
      service_item = ServiceItem.new
      service_item.parse(train_service)
      self.train_services << service_item
    end
  end

end

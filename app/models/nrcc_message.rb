class NrccMessage
  attr_accessor :category, :severity, :text

  def initialize(category, severity, text)
    @category = category
    @severity = severity
    @text = text
  end

end

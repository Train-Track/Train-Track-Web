include ActionView::Helpers::TextHelper
class ApiCall < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def self.add source, url, response, time
    body = truncate(response.body, length: 1000, escape: false)
    ApiCall.create(
      response_code: response.code,
      response: body,
      source: source,
      url: url,
      response_time: time
    )
  end

end

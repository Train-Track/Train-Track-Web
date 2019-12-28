include ActionView::Helpers::TextHelper
class ApiCall < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def self.add source, url, response, time
    if response.methods.include? 'body'
      body = truncate(response.body, length: 1000, escape: false)
    else
      body = response
    end
    if response.methods.include? 'code'
      code = response.code
    else
      code = 0
    end
    
    ApiCall.create(
      response_code: code,
      response: body,
      source: source,
      url: url,
      response_time: time
    )
  end

end

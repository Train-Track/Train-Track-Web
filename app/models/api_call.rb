class ApiCall < ActiveRecord::Base
  default_scope { order('created_at DESC') }

  def self.add source, url, response, time
    ApiCall.create(
      response_code: response.code,
      response: response.body,
      source: source,
      url: url,
      response_time: time
    )
  end

end

class RegistrationsController < Devise::RegistrationsController

  respond_to :html
  respond_to :json
  respond_to :xml

end
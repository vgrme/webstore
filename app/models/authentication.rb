require_relative 'form'

class Authentication < Form
  NEW_CUSTOMER = 'new'
  EXISTING_CUSTOMER = 'returning'

  attribute :email,       String
  attribute :registered,  String, default: NEW_CUSTOMER
  attribute :password,    String

  validates_presence_of :email
  validates_format_of :email, with: /.+@.+\..+/i

  def options
    [
      [I18n.t('models.webstore.authentication.new_customer'),      NEW_CUSTOMER],
      [I18n.t('models.webstore.authentication.existing_customer'), EXISTING_CUSTOMER],
    ]
  end

  def sign_in_attempt?
    registered == EXISTING_CUSTOMER || Customer.exists?(email: email, distributor_id: cart.distributor_id)
  end

  def default_option
    options.first.last
  end

  def distributor_parameter_name
    cart.distributor_parameter_name
  end

  def to_h
    {
      email:  email,
    }
  end
end

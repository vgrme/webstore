require_relative 'form'
require_relative '../webstore'

class Webstore::Completed < Webstore::Form
  attribute :cart

  def existing_customer?
    !customer.guest?
  end

  def distributor_parameter_name
    cart.distributor_parameter_name
  end

  def customer_name
    customer.name
  end

  def customer_address
    address.join('<br>')
  end

  def next_delivery_occurrence
    #@schedule_rule.next_occurrence.to_s(:day_month_date_year)
    '2013-12-12'
  end

  def schedule_description
    #@schedule_rule
    'Delivery monthly on the first Thursday'
  end

  def payment_message
    #If cod
    #@distributor.bank_information.cod_payment_message
    #if bank dep
    #distributor.bank_information.customer_message
    'This is Bank Info'
  end

  def bank_name
    #distributor.bank_information.name
    'a bank'
  end

  def bank_account_name
    #distributor.bank_information.account_name
    'an account'
  end

  def bank_bsb_number
    #distributor.bank_information.bsb_number
    '123'
  end

  def bank_account_number
    #distributor.bank_information.account_number
    '123'
  end

  def customer_number
    #distributor.bank_information.customer_number
    '0013'
  end

private

  def customer
    cart.customer
  end

  def address
    customer.address
  end
end
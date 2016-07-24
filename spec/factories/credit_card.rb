FactoryGirl.define do
  factory :credit_card do
    webpay_customer_id 'cus_xxxxxxx'
    year 2022
    last_digits 4242
    cc_type 'Visa'
    date 7
    name 'TEST TAROU'
  end
end

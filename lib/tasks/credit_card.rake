namespace :credit_card do
  desc 'bad user'
  task failed: :environment do
    webpay = WebPay.new(Settings.webpay.access_key)
    webpay.customer.create(
      card: 'tok_CardDeclined000',
      description: 'テスト失敗'
    )
  end
  desc 'failed recursion'
  task recursion_faild: :environment do
    webpay = WebPay.new(Settings.webpay.access_key)
    webpay.recursion.create(
      amount: 1000,
      currency: 'jpy',
      customer: 'cus_94X1TbeZgcEM9Mc',
      period: :month,
      description: "失敗課金"
    )
  end
end

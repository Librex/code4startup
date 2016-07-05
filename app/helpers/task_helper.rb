module TaskHelper
  def get_webpay_helper
    webpay = WebPay.new(Settings.webpay.access_key)
    user = webpay.customer.create(card: params["webpay-token"])
  end
end

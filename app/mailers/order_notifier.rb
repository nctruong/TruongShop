class OrderNotifier < ApplicationMailer

  def received(order)
    @order = order
    mail to: order.email, subject: "Truong's Store Order Confirmation"
  end

  def shipped
    @order = order
    mail to: order.email, subject: "Truong's Store Order Shipped"
  end
  
end

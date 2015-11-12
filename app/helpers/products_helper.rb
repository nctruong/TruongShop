module ProductsHelper
  def product_image(id)
    if File.exists? Rails.root.join('public', 'uploads', id.to_s)
      "/uploads/#{id}"
    else
      'coming-soon.png'
    end
  end
end
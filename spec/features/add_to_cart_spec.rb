require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see all products and then click add to cart. Once user navigates their cart product selected should be there." do
    visit root_path
    # add item to cart
    find(".btn.btn-primary", match: :first).click
    #confirm My Cart (# of items in cart is correct and click)
    find("li", :text => "My Cart (1)").click
    # confirm 1 item is listed
    expect(page).to have_css '.btn.btn-xs.btn-danger', count: 1
    save_and_open_screenshot
  end
end

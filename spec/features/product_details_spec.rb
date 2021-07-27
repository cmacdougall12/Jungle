require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
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

  scenario "They see all products and then click a product to view details and the products show page is rendered" do
    visit root_path
    find(".btn.btn-default.pull-right", match: :first).click
    expect(page).to have_css 'section.products-show'
    # save_and_open_screenshot
  end
end

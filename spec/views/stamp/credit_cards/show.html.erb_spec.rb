require 'spec_helper'

describe "credit_cards/show" do
  before(:each) do
    @credit_card = assign(:credit_card, stub_model(CreditCard,
      :id => 1,
      :card_number => 2,
      :name => "Name",
      :exp_date_month => 3,
      :exp_date_year => 4
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Name/)
    rendered.should match(/3/)
    rendered.should match(/4/)
  end
end

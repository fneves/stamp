require 'spec_helper'

describe "credit_cards/index" do
  before(:each) do
    assign(:credit_cards, [
      stub_model(CreditCard,
        :id => 1,
        :card_number => 2,
        :name => "Name",
        :exp_date_month => 3,
        :exp_date_year => 4
      ),
      stub_model(CreditCard,
        :id => 1,
        :card_number => 2,
        :name => "Name",
        :exp_date_month => 3,
        :exp_date_year => 4
      )
    ])
  end

  it "renders a list of credit_cards" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
  end
end

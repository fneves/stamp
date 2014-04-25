require 'spec_helper'

describe "credit_cards/new" do
  before(:each) do
    assign(:credit_card, stub_model(CreditCard,
      :id => 1,
      :card_number => 1,
      :name => "MyString",
      :exp_date_month => 1,
      :exp_date_year => 1
    ).as_new_record)
  end

  it "renders new credit_card form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", credit_cards_path, "post" do
      assert_select "input#credit_card_id[name=?]", "credit_card[id]"
      assert_select "input#credit_card_card_number[name=?]", "credit_card[card_number]"
      assert_select "input#credit_card_name[name=?]", "credit_card[name]"
      assert_select "input#credit_card_exp_date_month[name=?]", "credit_card[exp_date_month]"
      assert_select "input#credit_card_exp_date_year[name=?]", "credit_card[exp_date_year]"
    end
  end
end

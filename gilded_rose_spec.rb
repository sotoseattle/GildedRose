require './gilded_rose.rb'
require "minitest/autorun"

describe GildedRose do
  subject { GildedRose.new }

  it 'all items have a SellIn value (number of days to sell it)' do
    subject.items.first.must_respond_to sell_in
  end

end

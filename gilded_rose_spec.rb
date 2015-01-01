require './spec_helper.rb'
require './gilded_rose.rb'
require "minitest/autorun"

describe GildedRose do
  subject { GildedRose.new }

  it { subject.items.first.must_respond_to :sell_in }

  it { subject.items.first.must_respond_to :quality }

  it 'at the end of the day, quality decreases' do
    initial_quality = vest.quality
    subject.update_quality
    vest.quality.must_equal initial_quality - 1
  end

  it 'at the end of the day, the sell_in date decreases' do
    initial_sell_in = vest.sell_in
    subject.update_quality
    vest.sell_in.must_equal initial_sell_in  - 1
  end

  it 'once the sell_in reaches 0, quality falls twice as fast' do
    initial_quality = vest.quality
    11.times { subject.update_quality }
    vest.quality.must_equal initial_quality - 12
  end
end

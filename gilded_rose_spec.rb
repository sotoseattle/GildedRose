require './spec_helper.rb'
require './gilded_rose.rb'
require "minitest/autorun"

describe GildedRose do
  subject { GildedRose.new }

  it { subject.items.first.must_respond_to :sell_in }

  it { subject.items.first.must_respond_to :quality }

  describe 'standard items' do
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
      vest_at_expiration.quality.must_equal 10
      subject.update_quality
      vest.quality.must_equal 8
    end

    it 'quality cannot be negative' do
      (vest.quality + vest.sell_in).times { subject.update_quality }
      vest.quality.must_equal 0
    end
  end

  describe 'special case: Brie' do
    it 'brie is special, its quality grows up' do
      initial_quality = brie.quality
      subject.update_quality
      brie.quality.must_equal initial_quality + 1
    end

    it 'but quality cannot exceed 50' do
      50.times { subject.update_quality }
      brie.quality.must_equal 50
    end
  end

  describe 'special case: Sulfuras' do
    it 'never expires' do
      initial_sell_in = sulf.sell_in
      10.times { subject.update_quality }
      sulf.sell_in.must_equal initial_sell_in
    end

    it 'never goes bad' do
      initial_quality = sulf.quality
      10.times { subject.update_quality }
      sulf.quality.must_equal initial_quality
    end
  end

end

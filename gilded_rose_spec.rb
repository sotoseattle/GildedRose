require './spec_helper.rb'
require './gilded_rose.rb'
require "minitest/autorun"

describe GildedRose do
  subject { GildedRose.new }

  it { subject.items.first.must_respond_to :sell_in }

  it { subject.items.first.must_respond_to :quality }

  describe 'standard items' do
    it 'at the end of the day, quality decreases' do
      change_in_quality_after_updated(vest, 1).must_equal(-1)
    end

    it 'at the end of the day, the sell_in date decreases' do
      initial_sell_in = vest.sell_in
      subject.update_quality
      vest.sell_in.must_equal(initial_sell_in - 1)
    end

    it 'once the sell_in reaches 0, quality falls twice as fast' do
      change_in_quality_after_updated(vest, 11).must_equal(-12)
    end

    it 'quality cannot be negative' do
      total = vest.quality
      change_in_quality_after_updated(vest, 100).must_equal(-total)
      vest.quality.must_equal 0
    end
  end

  describe 'special item: Brie' do
    it 'brie is special, its quality grows up' do
      change_in_quality_after_updated(brie, 1).must_equal(+1)
    end

    it 'but quality cannot exceed 50' do
      52.times { subject.update_quality }
      brie.quality.must_equal 50
    end
  end

  describe 'special item: Sulfuras' do
    it 'never expires' do
      initial_sell_in = sulf.sell_in
      10.times { subject.update_quality }
      sulf.sell_in.must_equal initial_sell_in
    end

    it 'never goes bad' do
      change_in_quality_after_updated(sulf, 10).must_equal(0)
    end
  end

  describe 'special item: backstage pass' do
    it 'quality increases up to 10 days before concert' do
      change_in_quality_after_updated(tafk, 1).must_equal(1)
    end

    it 'quality increases by 2 from 10 to 6 days before concert' do
      6.times { subject.update_quality }
      change_in_quality_after_updated(tafk, 1).must_equal(2)
    end

    it 'quality increases by 3 from 5 to the day of the concert' do
      10.times { subject.update_quality }
      change_in_quality_after_updated(tafk, 1).must_equal(3)
    end

    it 'quality becomes 0 on the day of the concert' do
      15.times { subject.update_quality }
      tafk.quality.must_equal 0
    end

    it 'quality remains at 0 after the concert' do
      16.times { subject.update_quality }
      change_in_quality_after_updated(tafk, 1).must_equal(0)
    end
  end

  describe 'special item: conjured' do
    it 'quality falls twice as fast as standard items' do
      change_in_quality_after_updated(conj, 1).must_equal(-2)
    end
  end
end

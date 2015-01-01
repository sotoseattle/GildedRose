require './item.rb'

class GildedRose
  attr_reader :items

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    items.each { |item| enhance(item).update! }
  end

  def enhance(item)
    case item.name
    when /^Aged Brie/ then item.extend(Cheese)
    when /^Sulfuras/  then item.extend(Sulfuras)
    when /^Backstage/ then item.extend(Concert)
    when /^Conjured/  then item.extend(Conjure)
    else                   item.extend(Standard)
    end
    item
  end
end

module Updater
  def one_day_passes
    @sell_in -= 1
  end

  def verify_quality_limits
    return if @quality.between?(0, 50)
    @quality = (@quality > 0 ? 50 : 0)
  end
end

module Standard
  include Updater
  def update!
    one_day_passes
    @quality -= (@sell_in >= 0 ? 1 : 2)
    verify_quality_limits
  end
end

module Cheese
  include Updater
  def update!
    one_day_passes
    @quality += 1
    verify_quality_limits
  end
end

module Sulfuras
  def update!
  end
end

module Concert
  include Updater
  def update!
    one_day_passes

    return @quality = 0 if @sell_in <= 0
    case @sell_in
    when (1..5)  then @quality += 3
    when (6..10) then @quality += 2
    else              @quality += 1
    end
    verify_quality_limits
  end
end

module Conjure
  include Updater
  def update!
    one_day_passes
    2.times { @quality -= (@sell_in >= 0 ? 1 : 2) }
    verify_quality_limits
  end
end


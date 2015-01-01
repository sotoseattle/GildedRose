require './item.rb'

class Stuff
  def initialize(item)
    @item = item
  end

  def one_day_passes
    @item.sell_in -= 1
  end

  def verify_quality_limits
    return if @item.quality.between?(0, 50)
    @item.quality = (@item.quality > 0 ? 50 : 0)
  end
end

class Standard < Stuff
  def update
    one_day_passes
    @item.quality -= (@item.sell_in >= 0 ? 1 : 2)
    verify_quality_limits
  end
end

class Cheese < Stuff
  def update
    one_day_passes
    @item.quality += 1
    verify_quality_limits
  end
end

class Sulfuras < Stuff
  def update
  end
end

class Concert < Stuff
  def update
    one_day_passes

    return @item.quality = 0 if @item.sell_in <= 0
    case @item.sell_in
    when (1..5)  then @item.quality += 3
    when (6..10) then @item.quality += 2
    else              @item.quality += 1
    end
    verify_quality_limits
  end
end

class Conjure < Stuff
  def update
    one_day_passes
    2.times { @item.quality -= (@item.sell_in >= 0 ? 1 : 2) }
    verify_quality_limits
  end
end

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
    items.each do |item|
      case item.name
      when 'Aged Brie' then Cheese.new(item).update
      when 'Sulfuras, Hand of Ragnaros' then Sulfuras.new(item).update
      when 'Backstage passes to a TAFKAL80ETC concert' then Concert.new(item).update
      when 'Conjured Mana Cake' then Conjure.new(item).update
      else Standard.new(item).update
      end
    end
  end
end

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
    items.each do |item|
      case item.name
      when 'Aged Brie'
        for_all_items(:update_brie, item)
      when 'Sulfuras, Hand of Ragnaros'
        for_all_items(:update_sulfuras, item)
      when 'Backstage passes to a TAFKAL80ETC concert'
        for_all_items(:update_concert, item)
      when 'Conjured Mana Cake'
        for_all_items(:update_conjure, item)
      else
        for_all_items(:update_as_standard, item)
      end
    end
  end

  def for_all_items(quality_updater, item)
    one_day_passes(item)

    public_send(quality_updater, item)

    verify_quality_limits(item) unless quality_updater == :update_sulfuras
  end


  def one_day_passes(item)
    item.sell_in -= 1
  end

  def verify_quality_limits(item)
    return if item.quality.between?(0, 50)
    item.quality = (item.quality > 0 ? 50 : 0)
  end

  def update_as_standard(item)
    item.quality -= (item.sell_in >= 0 ? 1 : 2)
    item.quality = 0 if item.quality < 0
  end

  def update_brie(item)
    item.quality += 1 unless item.quality == 50
  end

  def update_sulfuras(item)
    item.sell_in = 0
  end

  def update_concert(item)
    return item.quality = 0 if item.sell_in <= 0

    case item.sell_in
    when (1..5)  then item.quality += 3
    when (6..10) then item.quality += 2
    else              item.quality += 1
    end
  end

  def update_conjure(item)
    2.times { update_as_standard(item) }
  end
end

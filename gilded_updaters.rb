class ItemUpdater < Module
  def initialize(item)
    define_method 'update!', item_update(item.name)
  end

  private

  def item_update(name)
    define_method :update_sell_date, -> { @sell_in -= 1 }

    define_method :quality_limits do
      return if @quality.between?(0, 50)
      @quality = (@quality > 0 ? 50 : 0)
    end

    case name
    when /^Aged Brie/ then cheesy_update
    when /^Sulfuras/  then sulfuric_update
    when /^Backstage/ then tickety_update
    when /^Conjured/  then conjured_update
    else                   standard_update
    end
  end

  # Each Item updates quality and sell_in in different ways

  def standard_update
    lambda do
      update_sell_date
      @quality -= (@sell_in >= 0 ? 1 : 2)
      quality_limits
    end
  end

  def cheesy_update
    lambda do
      update_sell_date
      @quality += 1
      quality_limits
    end
  end

  def sulfuric_update
    -> {}
  end

  def tickety_update
    lambda do
      update_sell_date
      return @quality = 0 if @sell_in <= 0
      case @sell_in
      when (1..5)  then @quality += 3
      when (6..10) then @quality += 2
      else              @quality += 1
      end
      quality_limits
    end
  end

  def conjured_update
    lambda do
      update_sell_date
      2.times { @quality -= (@sell_in >= 0 ? 1 : 2) }
      quality_limits
    end
  end
end


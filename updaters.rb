module Basic_Updater
  def one_day_passes
    @sell_in -= 1
  end

  def verify_quality_limits
    return if @quality.between?(0, 50)
    @quality = (@quality > 0 ? 50 : 0)
  end
end

module Standard
  include Basic_Updater
  def update!
    one_day_passes
    @quality -= (@sell_in >= 0 ? 1 : 2)
    verify_quality_limits
  end
end

module Cheesy
  include Basic_Updater
  def update!
    one_day_passes
    @quality += 1
    verify_quality_limits
  end
end

module Sulfuric
  def update!
  end
end

module Tickety
  include Basic_Updater
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

module Conjured
  include Basic_Updater
  def update!
    one_day_passes
    2.times { @quality -= (@sell_in >= 0 ? 1 : 2) }
    verify_quality_limits
  end
end


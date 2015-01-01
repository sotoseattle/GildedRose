def change_in_quality_after_updated(something, n)
  initial_quality = something.quality
  n.times { subject.update_quality }
  something.quality - initial_quality
end

def vest
  subject.items.detect { |i| i.name == "+5 Dexterity Vest" }
end

def brie
  subject.items.detect { |i| i.name == "Aged Brie" }
end

def sulf
  subject.items.detect { |i| i.name == "Sulfuras, Hand of Ragnaros" }
end

def tafk
  subject.items.detect { |i| i.name == "Backstage passes to a TAFKAL80ETC concert" }
end

def conj
  subject.items.detect { |i| i.name == "Conjured Mana Cake" }
end


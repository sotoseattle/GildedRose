
def vest
  subject.items.detect { |i| i.name == "+5 Dexterity Vest" }
end

def vest_at_expiration
  10.times { subject.update_quality }
  subject.items.detect { |i| i.name == "+5 Dexterity Vest" }
end

def brie
  subject.items.detect { |i| i.name == "Aged Brie" }
end

def mong
  subject.items.detect { |i| i.name == "Elixir of the Mongoose" }
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


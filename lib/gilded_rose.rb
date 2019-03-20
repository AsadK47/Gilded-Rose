class GildedRose
  def initialize(items)
    @items = items
  end

  def item_quality
    @items.each do |item|
      item.sell_in -= 1
      item.quality -= 1 unless item.quality == 0
      if item.sell_in <= 0
        item.quality -= 1 unless item.quality == 0
      end
    end
  end

  def brie_quality
    @items.each do |item|
      return self if item.quality >= 50

      item.quality += 1
      item.quality += 1 if item.sell_in <= 0 && item.quality < 48
    end
  end

  def backstage_pass_quality
    @items.each do |item|
      return self if item.quality >= 50 && item.sell_in > 0

      item.quality += 1
      item.quality += 1 if item.sell_in < 11 && item.quality < 50
      item.quality += 1 if item.sell_in < 6 && item.quality < 50
      item.sell_in == 0 ? item.quality = 0 : nil
    end
  end

  def sulfuras_quality
  end

  def update_quality
    @items.each do |item|
      if item.name == 'item'
        item_quality
      elsif item.name == 'Aged Brie'
        brie_quality
      elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
        backstage_pass_quality
      elsif item.name == "Sulfuras, Hand of Ragnaros"
        sulfuras_quality
      end
    end
  end

end

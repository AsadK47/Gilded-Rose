class GildedRose
  def initialize(items)
    @items = items
    @list_of_items = { 'item' => method(:item_quality).to_proc, 'Aged Brie' => method(:brie_quality).to_proc, 'Backstage passes to a TAFKAL80ETC concert' => method(:backstage_pass_quality).to_proc, 'Sulfuras, Hand of Ragnaros' => method(:sulfuras_quality).to_proc }
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
      if item.sell_in == 0
        item.quality = 0
      end
    end
  end

  def sulfuras_quality
  end

  def update_quality
    @list_of_items.each do |key, value|
      @items.each do |item|
        if item.name == key
          value.call
        end
      end
    end
  end
end

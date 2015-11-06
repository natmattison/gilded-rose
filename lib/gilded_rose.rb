def update_quality(items)
  items.each do |item|
    if item.name == 'Sulfuras, Hand of Ragnaros'
      item.quality = 80
      item.sell_in = nil
      next
    end
    if item.name == 'Aged Brie'
      item.quality += 1
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      if item.sell_in <= 0
        item.quality = 0
      elsif item.sell_in <= 6
        item.quality += 3
      elsif item.sell_in <= 11
        item.quality += 2
      else
        item.quality += 1
      end
    elsif item.name == 'Conjured'
      quality_decrease = item.sell_in < 0 ? 4 : 2
      item.quality -= quality_decrease
    else # normal items
      quality_decrease = item.sell_in < 0 ? 2 : 1
      item.quality -= quality_decrease
    end
    
    item.sell_in -= 1
    
    # enforce 0 < quality < 50
    if item.quality > 50
      item.quality = 50
    elsif item.quality < 0
      item.quality = 0
    end
    
  end
end

######### DO NOT CHANGE BELOW #########

Item = Struct.new(:name, :sell_in, :quality)

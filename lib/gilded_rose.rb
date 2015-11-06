def update_quality(items)
  items.each do |item|
    if item.name == 'Sulfuras, Hand of Ragnaros'
      item.quality = 80
      item.sell_in = nil
      next
    end
    
    item.sell_in -= 1
    
    if item.name == 'Aged Brie'
      quality_change = 1
    elsif item.name == 'Backstage passes to a TAFKAL80ETC concert'
      if item.sell_in <= 0
        quality_change = -item.quality
      elsif item.sell_in <= 5
        quality_change = 3
      elsif item.sell_in <= 10
        quality_change = 2
      else
        quality_change = 1
      end
    elsif item.name == 'Conjured'
      quality_change = item.sell_in < 0 ? -4 : -2
    else # normal items
      quality_change = item.sell_in < 0 ? -2 : -1
    end
    
    item.quality += quality_change
    
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

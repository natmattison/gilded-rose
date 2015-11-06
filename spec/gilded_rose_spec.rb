require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with normal items" do
    let(:items) {
      [
        Item.new("Normal item", 5, 10),
        Item.new("Normal item", -1, 10)
      ]
    }

    before { update_quality(items) }

    it "decreases quality and sell_in by one" do
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(9)
    end
    
    it "decreases quality by two when sell_in is negative" do
      expect(items[1].quality).to eq(8)
    end
  end

  context "with backstage pass items" do
    let(:items) {
      [
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 48),
      ]
    }

    before { update_quality(items) }

    it "increases quality when sell_in is over 10" do
      expect(items[0].quality).to eq(11)
      expect(items[0].sell_in).to eq(14)
    end

    it "increases quality by 2 when 5 < sell_in <= 10" do
      expect(items[1].quality).to eq(12)
    end

    it "increases quality by 3 when 0 < sell_in <= 5" do
      expect(items[2].quality).to eq(13)
    end

    it "sets quality to 0 when concert has passed" do
      expect(items[3].quality).to eq(0)
    end

    it "caps quality at 50" do
      expect(items[4].quality).to eq(50)
    end

  end

  context "with aged brie items" do
    let(:items) {
      [
        Item.new("Aged Brie", 5, 10),
        Item.new("Aged Brie", 3, 50)
      ]
    }
    
    before { update_quality(items) }

    it "increases quality and decreases sell_in" do
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(11)
    end
    
    it "quality does not increase above 50" do
      expect(items[1].quality).to eq(50)
    end
  end
  
  context "with Sulfuras items" do
    let(:initial_sell_in) { nil }
    let(:initial_quality) { 80 }
    let(:name) { "Sulfuras, Hand of Ragnaros" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "keeps quality set at 80 and no sell_in" do
      expect(item.quality).to eq(80)
      expect(item.sell_in).to eq(nil)
    end
  end
  
  context "with Conjured items" do
    let(:items) {
      [
        Item.new("Conjured", 5, 10),
        Item.new("Conjured", 1, 1),
        Item.new("Conjured", -1, 10)
      ]
    }
    
    before { update_quality(items) }

    it "decreases quality by two and sell_in by one" do
      expect(items[0].sell_in).to eq(4)
      expect(items[0].quality).to eq(8)
    end
    
    it "decreases quality by four when sell_in is negative" do
      expect(items[2].quality).to eq(6)
    end
    
    it "does not allow quality to be negative" do
      expect(items[1].quality).to eq(0)
    end
  end
end

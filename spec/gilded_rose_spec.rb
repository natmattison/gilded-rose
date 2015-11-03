require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single normal item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "decreases quality and sell_in by one" do
      expect(item.sell_in).to eq(initial_sell_in - 1)
      expect(item.quality).to eq(initial_quality - 1)
    end
  end

  context "with backstage pass items" do
    let(:items) {
      [
        Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 10),
        Item.new("Backstage passes to a TAFKAL80ETC concert", 2, 48),
      ]
    }

    before { update_quality(items) }

    it "increases quality when sell_in is over 10" do
      expect(items[0].quality).to eq(11)
      expect(items[0].sell_in).to eq(14)
    end

    it "increases quality by 2 when 5 < sell_in < 10" do
      expect(items[1].quality).to eq(12)
    end

    it "increases quality by 3 when 0 < sell_in < 5" do
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
  
  context "with conjured items" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "Conjured" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "decreases quality by two and sell_in by one" do
      expect(item.sell_in).to eq(initial_sell_in - 1)
      expect(item.quality).to eq(initial_quality - 2)
    end
  end
end

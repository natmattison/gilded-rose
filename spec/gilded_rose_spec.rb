require_relative '../lib/gilded_rose'

describe "#update_quality" do

  context "with a single item" do
    let(:initial_sell_in) { 5 }
    let(:initial_quality) { 10 }
    let(:name) { "item" }
    let(:item) { Item.new(name, initial_sell_in, initial_quality) }

    before { update_quality([item]) }

    it "decreases quality and sell in by one" do
      expect(item.sell_in).to eq(initial_sell_in - 1)
      expect(item.quality).to eq(initial_quality - 1)
    end
  end

  context "with multiple items" do
    let(:items) {
      [
        Item.new("NORMAL ITEM", 5, 10),
        Item.new("Aged Brie", 3, 10)
      ]
    }

    before { update_quality(items) }

    it "decreases quality and sell in for normal item" do
      expect(items[0].quality).to eq(9)
      expect(items[0].sell_in).to eq(4)
    end
    
    it "increases quality for Aged Brie" do
      expect(items[1].quality).to eq(11)
    end
    
    it "decreases sell in for Aged Brie" do
      expect(items[1].sell_in).to eq(2)
    end
    
  end
end

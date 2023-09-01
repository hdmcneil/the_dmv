require 'pry'
require './lib/registrant'
require 'rspec'

describe Registrant do
  before :each do
    @registrant = Registrant.new(@name, @age)
    @registrant_1 = Registrant.new('Bruce', 18, true )
    @registrant_2 = Registrant.new('Penny', 15 )
  end

  describe '#initialize' do
    it 'can initialize' do
      expect(@registrant).to be_an_instance_of(Registrant)
      expect(@registrant_1.name).to eq("Bruce")
      expect(@registrant_1.age).to eq(18)
      expect(@registrant_1.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
      expect(@registrant_2.name).to eq("Penny")
      expect(@registrant_2.age).to eq(15)
      expect(@registrant_2.license_data).to eq({:written=>false, :license=>false, :renewed=>false})
    end

    it 'has a permit' do
      expect(@registrant_1.permit?).to be(true)
      expect(@registrant_2.permit?).to eq(false)
    end

    it 'earns a permit' do
      @registrant_2.earn_permit
      expect(@registrant_2.permit?).to eq(true)
    end

  end

end
require 'rails_helper'

RSpec.describe Plot do
  describe 'relationships' do
    it { should belong_to(:garden) }
    it { should have_many(:plant_plots) }
    it { should have_many(:plants).through(:plant_plots) }
  end

  describe 'instance methods' do

    it "can return a unique list of plants names with under 100 days to harvest" do
      garden1 = Garden.create!(name: 'Botanical', organic: true)

      plot = Plot.create!(number: 100, size: 'Large', direction: 'West', garden_id: garden1.id)

      plant1 = Plant.create!(name: 'Rose', description: 'loves the moon light', days_to_harvest: 105)
      plant2 = Plant.create!(name: 'Daisy', description: 'prefers cold climate', days_to_harvest: 100)
      plant3 = Plant.create!(name: 'Flower', description: 'likes electrolites', days_to_harvest: 8)
      plant4 = Plant.create!(name: 'Daisy', description: 'long thorny rose', days_to_harvest: 18)
      plant5 = Plant.create!(name: 'Tulap', description: 'Hates the sun', days_to_harvest: 19)

      plantplot1 = PlantPlot.create!(plot_id: plot.id, plant_id:plant1.id)
      plantplot2 = PlantPlot.create!(plot_id: plot.id, plant_id:plant2.id)
      plantplot3 = PlantPlot.create!(plot_id: plot.id, plant_id:plant3.id)
      plantplot4 = PlantPlot.create!(plot_id: plot.id, plant_id:plant4.id)
      plantplot5 = PlantPlot.create!(plot_id: plot.id, plant_id:plant5.id)

      expect(plot.unique_plants).to eq(['Daisy', 'Flower', 'Tulap'])
    end
  end
end

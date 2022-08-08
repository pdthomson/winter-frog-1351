require 'rails_helper'

RSpec.describe 'garden show page' do

  it "can show you the list of unique plants in a gardens plot with less than 100 days to harvest" do
    garden1 = Garden.create!(name: 'Botanical', organic: true)
    garden2 = Garden.create!(name: 'Rose Haven', organic: false)

    plot1 = Plot.create!(number: 2, size: 'Large', direction: 'West', garden_id: garden1.id)
    plot2 = Plot.create!(number: 5, size: 'Small', direction: 'North', garden_id: garden1.id)
    plot3 = Plot.create!(number: 10, size: 'Medium', direction: 'East', garden_id: garden1.id)
    plot4 = Plot.create!(number: 19, size: 'Medium', direction: 'East', garden_id: garden2.id)
    plot5 = Plot.create!(number: 21, size: 'Smedium', direction: 'North-East', garden_id: garden2.id)

    plant1 = Plant.create!(name: 'Flower', description: 'loves the moon light', days_to_harvest: 100)
    plant2 = Plant.create!(name: 'Daisy', description: 'prefers cold climate', days_to_harvest: 10)
    plant3 = Plant.create!(name: 'Gatorade Rose', description: 'likes electrolites', days_to_harvest: 8)
    plant4 = Plant.create!(name: 'Rose whip', description: 'long thorny rose', days_to_harvest: 99)
    plant5 = Plant.create!(name: 'Tulap', description: 'Hates the sun', days_to_harvest: 19)

    plantplot1 = PlantPlot.create!(plot_id: plot1.id, plant_id:plant1.id)
    plantplot2 = PlantPlot.create!(plot_id: plot2.id, plant_id:plant2.id)
    plantplot3 = PlantPlot.create!(plot_id: plot3.id, plant_id:plant3.id)
    plantplot4 = PlantPlot.create!(plot_id: plot4.id, plant_id:plant4.id)
    plantplot5 = PlantPlot.create!(plot_id: plot5.id, plant_id:plant5.id)

    visit "/gardens/#{garden1.id}"

    within "div#garden" do
      expect(page).to have_content('Daisy')
      expect(page).to have_content('Gatorade Rose')
      expect(page).to_not have_content('Flower')
      expect(page).to_not have_content('Rose whip')
      expect(page).to_not have_content('Tulap_not')
    end

    visit "/gardens/#{garden2.id}"

    within "div#garden" do
      expect(page).to have_content('Rose whip')
      expect(page).to have_content('Tulap')
      expect(page).to_not have_content('Daisy')
      expect(page).to_not have_content('Gatorade Rose')
      expect(page).to_not have_content('Flower')
    end
  end
end

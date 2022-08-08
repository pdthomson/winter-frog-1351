require 'rails_helper'

RSpec.describe 'plant index page' do

  it "can show us the plots number and all of the plants in the plot" do
    garden1 = Garden.create!(name: 'Botanical', organic: true)
    garden2 = Garden.create!(name: 'Rose Haven', organic: false)

    plot1 = Plot.create!(number: 2, size: 'Large', direction: 'West', garden_id: garden1.id)
    plot2 = Plot.create!(number: 5, size: 'Small', direction: 'North', garden_id: garden1.id)
    plot3 = Plot.create!(number: 10, size: 'Medium', direction: 'East', garden_id: garden1.id)
    plot4 = Plot.create!(number: 19, size: 'Medium', direction: 'East', garden_id: garden2.id)
    plot5 = Plot.create!(number: 21, size: 'Smedium', direction: 'North-East', garden_id: garden2.id)

    plant1 = Plant.create!(name: 'Flower', description: 'loves the moon light', days_to_harvest: 5)
    plant2 = Plant.create!(name: 'Daisy', description: 'prefers cold climate', days_to_harvest: 10)
    plant3 = Plant.create!(name: 'Gatorade Rose', description: 'likes electrolites', days_to_harvest: 8)
    plant4 = Plant.create!(name: 'Rose whip', description: 'long thorny rose', days_to_harvest: 18)
    plant5 = Plant.create!(name: 'Sunflower', description: 'Hates the sun', days_to_harvest: 19)

    plantplot1 = PlantPlot.create!(plot_id: plot1.id, plant_id:plant1.id)
    plantplot2 = PlantPlot.create!(plot_id: plot2.id, plant_id:plant2.id)
    plantplot3 = PlantPlot.create!(plot_id: plot3.id, plant_id:plant3.id)
    plantplot4 = PlantPlot.create!(plot_id: plot4.id, plant_id:plant4.id)
    plantplot5 = PlantPlot.create!(plot_id: plot5.id, plant_id:plant5.id)

    visit "/plots"

    within "div#plots" do
      expect(page).to have_content(2)
      expect(page).to have_content(5)
      expect(page).to have_content(10)
      expect(page).to have_content(19)
      expect(page).to have_content(21)
      expect(page).to have_content('Flower')
      expect(page).to have_content('Daisy')
      expect(page).to have_content('Sunflower')
      expect(page).to have_content('Gatorade Rose')
      expect(page).to have_content('Rose whip')
      expect(page).to_not have_content('long throny rose')
      expect(page).to_not have_content('Hates the sun')
      expect(page).to_not have_content('West')
      expect(page).to_not have_content('East')
    end
  end

  it "can remove a plant from a plot" do
    garden1 = Garden.create!(name: 'Botanical', organic: true)
    garden2 = Garden.create!(name: 'Rose Haven', organic: false)

    plot1 = Plot.create!(number: 2, size: 'Large', direction: 'West', garden_id: garden1.id)
    plot2 = Plot.create!(number: 5, size: 'Small', direction: 'North', garden_id: garden1.id)
    plot3 = Plot.create!(number: 10, size: 'Medium', direction: 'East', garden_id: garden1.id)
    plot4 = Plot.create!(number: 19, size: 'Medium', direction: 'East', garden_id: garden2.id)
    plot5 = Plot.create!(number: 21, size: 'Smedium', direction: 'North-East', garden_id: garden2.id)

    plant1 = Plant.create!(name: 'Flower', description: 'loves the moon light', days_to_harvest: 5)
    plant2 = Plant.create!(name: 'Daisy', description: 'prefers cold climate', days_to_harvest: 10)
    plant3 = Plant.create!(name: 'Gatorade Rose', description: 'likes electrolites', days_to_harvest: 8)
    plant4 = Plant.create!(name: 'Rose whip', description: 'long thorny rose', days_to_harvest: 18)
    plant5 = Plant.create!(name: 'Tulap', description: 'Hates the sun', days_to_harvest: 19)

    plantplot1 = PlantPlot.create!(plot_id: plot1.id, plant_id:plant1.id)
    plantplot2 = PlantPlot.create!(plot_id: plot2.id, plant_id:plant2.id)
    plantplot3 = PlantPlot.create!(plot_id: plot3.id, plant_id:plant3.id)
    plantplot4 = PlantPlot.create!(plot_id: plot4.id, plant_id:plant4.id)
    plantplot5 = PlantPlot.create!(plot_id: plot5.id, plant_id:plant5.id)

    visit '/plots'

      expect(page).to have_content('Flower')
      expect(page).to have_content('Daisy')
      expect(page).to have_content('Rose whip')

    within "div#plant-#{plant1.id}" do
      expect(page).to have_content('Flower')
      expect(page).to have_button('Remove Flower')
      click_on('Remove Flower')
      expect(current_path).to eq('/plots')
    end

      expect(page).to have_content('Daisy')
      expect(page).to have_content('Rose whip')
      expect(page).to_not have_content('Flower')

    within "div#plant-#{plant5.id}" do
      expect(page).to have_content('Tulap')
      expect(page).to have_button('Remove Tulap')
      click_on('Remove Tulap')
      expect(current_path).to eq('/plots')
    end

      expect(page).to have_content('Daisy')
      expect(page).to_not have_content('Flower')
      expect(page).to_not have_content('Tulap')

      expect(Plant.find("#{plant1.id}")).to eq(plant1)
  end
end

class Plot < ApplicationRecord
  belongs_to :garden
  has_many :plant_plots
  has_many :plants, through: :plant_plots

  def unique_plants
    plants.where('days_to_harvest < ?', 100).distinct.pluck(:name)
  end
end

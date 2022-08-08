Rails.application.routes.draw do
  get '/plots', to: 'plots#index'
  delete '/plots/:plot_id/plants/:plant_id', to: 'plant_plots#delete'
  get '/gardens/:garden_id', to: 'gardens#show'
end

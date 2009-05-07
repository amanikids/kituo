ActionController::Routing::Routes.draw do |map|
  map.resources :children do |child|
    child.resource :headshot

    child.resources :arrivals, :reunifications, :dropouts, :terminations
  end

  map.root :controller => 'children'
end

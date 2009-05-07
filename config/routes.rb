ActionController::Routing::Routes.draw do |map|
  map.resources :children do |child|
    child.resource :headshot

    child.resources :arrivals, :reunifications, :dropouts
  end

  map.root :controller => 'children'
end

ActionController::Routing::Routes.draw do |map|
  map.resources :children, :collection => { :offsite_boardings => :get, :dropouts => :get, :reunifications => :get, :terminations => :get } do |child|
    child.resource :headshot
    child.resources :arrivals, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.root :controller => 'children'
end

ActionController::Routing::Routes.draw do |map|
  map.resources :children, :collection => { :dropped_out => :get } do |child|
    child.resource :headshot
    child.resources :arrivals, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.root :controller => 'children'
end

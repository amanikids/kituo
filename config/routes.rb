ActionController::Routing::Routes.draw do |map|
  map.filter 'locale'

  map.resources :children, :collection => { :pending => :get, :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get } do |child|
    child.resource :headshot
    child.resources :arrivals, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.root :controller => 'children'
end

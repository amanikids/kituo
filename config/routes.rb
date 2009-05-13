ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :children, :collection => { :pending => :get, :onsite => :get, :needing_home_visit => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get } do |child|
    child.resource :headshot
    child.resources :arrivals, :home_visits, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.root :controller => 'children'
end

ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :tasks, :collection => { :unrecorded_arrivals => :get, :upcoming_home_visits => :get }

  map.resources :children, :collection => { :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get }, :member => { :headshot => :get } do |child|
    child.resource :case_assignment, :controller => 'children/case_assignments'
    child.resources :arrivals, :home_visits, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.resources :caregivers, :member => { :headshot => :get }

  map.root :controller => 'children'
end

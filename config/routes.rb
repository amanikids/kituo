ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :tasks, :collection => { :unrecorded_arrivals => :get, :upcoming_home_visits => :get }

  map.resources :children, :collection => { :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get }, :member => { :headshot => :get } do |child|
    child.resources :arrivals, :controller => 'children/arrivals'
    child.resources :home_visits, :controller => 'children/home_visits'
    child.resources :offsite_boardings, :controller => 'children/offsite_boardings'
    child.resources :reunifications, :controller => 'children/reunifications'
    child.resources :dropouts, :controller => 'children/dropouts'
    child.resources :terminations, :controller => 'children/terminations'

    child.resource :case_assignment, :controller => 'children/case_assignments'
  end

  map.resources :caregivers, :member => { :headshot => :get }

  map.root :controller => 'children'
end

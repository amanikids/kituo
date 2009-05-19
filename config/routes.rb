ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :tasks, :collection => { :unrecorded_arrivals => :get, :upcoming_home_visits => :get }

  map.resources :children, :collection => { :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get } do |child|
    child.resources :arrivals, :controller => 'children/arrivals'
    child.resources :home_visits, :controller => 'children/home_visits'
    child.resources :offsite_boardings, :controller => 'children/offsite_boardings'
    child.resources :reunifications, :controller => 'children/reunifications'
    child.resources :dropouts, :controller => 'children/dropouts'
    child.resources :terminations, :controller => 'children/terminations'

    child.resource :case_assignment, :controller => 'children/case_assignments'
    child.resource :headshot, :controller => 'children/headshots'
  end

  map.resources :caregivers do |caregiver|
    caregiver.resource :headshot, :controller => 'caregivers/headshots'
  end

  map.root :controller => 'children'
end

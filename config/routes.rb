ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :tasks

  map.resources :children, :collection => { :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get } do |child|
    child.resources :arrivals, :controller => 'children/arrivals'
    child.resources :home_visits, :controller => 'children/home_visits'
    child.resources :offsite_boardings, :controller => 'children/offsite_boardings'
    child.resources :reunifications, :controller => 'children/reunifications'
    child.resources :dropouts, :controller => 'children/dropouts'
    child.resources :terminations, :controller => 'children/terminations'

    child.resource :headshot, :controller => 'children/headshots'
    child.resource :social_worker, :controller => 'children/social_workers'
  end

  map.resources :caregivers do |caregiver|
    caregiver.resource :headshot, :controller => 'caregivers/headshots'
  end

  map.resources :statistics, :collection => { :length_of_stay => :get }

  map.root :controller => 'children'
end

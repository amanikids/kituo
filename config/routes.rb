ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :tasks, :collection => { :unrecorded_arrivals => :get, :upcoming_home_visits => :get }

  map.resources :children, :collection => { :onsite => :get, :boarding_offsite => :get, :dropped_out => :get, :reunified => :get, :terminated => :get } do |child|
    child.resource :headshot # FIXME delete the HeadshotsController and make headshot be a member action for a Child
    child.resources :arrivals, :home_visits, :offsite_boardings, :reunifications, :dropouts, :terminations
  end

  map.resources :caregivers, :member => { :headshot => :get }

  map.root :controller => 'children'
end

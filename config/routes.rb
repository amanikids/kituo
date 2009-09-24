ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.length_of_stay_statistics '/statistics/length_of_stay.svg', :controller => 'statistics', :action => 'length_of_stay', :format => :svg, :conditions => { :method => :get }

  map.resource :session
  map.resources :children, :collection => {:on_site => :get}
  map.resources :caregivers
  map.resources :events
  map.resources :scheduled_visits, :member => {:complete => :put}
  map.root :controller => 'dashboard', :action => 'show'
end

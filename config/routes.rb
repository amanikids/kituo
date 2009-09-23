ActionController::Routing::Routes.draw do |map|
  map.filter :locale

  map.resources :statistics, :collection => { :length_of_stay => :get }

  map.resource :session
  map.resources :children, :events
  map.resources :scheduled_visits, :member => {:complete => :put}
  map.root :controller => 'dashboard', :action => 'show'
end

ActionController::Routing::Routes.draw do |map|
  map.resources :children do |child|
    child.resource :headshot

    child.resources :arrivals
  end

  map.root :controller => 'children'
end

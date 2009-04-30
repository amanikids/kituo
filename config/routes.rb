ActionController::Routing::Routes.draw do |map|
  map.resources :children do |child|
    child.resources :arrivals, :shallow => true
  end

  map.root :controller => 'children'
end

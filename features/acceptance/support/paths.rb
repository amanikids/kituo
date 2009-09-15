module NavigationHelpers
  def path_to(page_name)
    {
      "the home page" => '/mockups',
      "the english home page" => '/en/mockups'
    }[page_name]
  end
end

World(NavigationHelpers)

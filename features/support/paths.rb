module NavigationHelpers
  def path_to(page_name)
    {
      "the home page"         => '/',
      "the english home page" => '/en/mockups',
      "the english dashboard" => '/en'
    }[page_name]
  end
end

World(NavigationHelpers)

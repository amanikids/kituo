module NavigationHelpers
  # Maps a static name to a static route.
  #
  # This method is *not* designed to map from a dynamic name to a
  # dynamic route like <tt>post_comments_path(post)</tt>. For dynamic
  # routes like this you should *not* rely on #path_to, but write
  # your own step definitions instead. Example:
  #
  #   Given /I am on the comments page for the "(.+)" post/ |name|
  #     post = Post.find_by_name(name)
  #     visit post_comments_path(post)
  #   end
  #
  def path_to(page_name)
    case page_name

    when /the homepage/
      root_path

    when /the new child page/
      new_child_path

    when /the offsite boardings children page/
      offsite_boardings_children_path

    when /the dropouts children page/
      dropouts_children_path

    when /the reunifications children page/
      reunifications_children_path

    when /the terminations children page/
      terminations_children_path

    when /the child page for "(.+)"/
      child_path(Child.find_by_name!($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

World(NavigationHelpers)

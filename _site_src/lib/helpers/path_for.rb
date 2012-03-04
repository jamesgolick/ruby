module TCS

module PathForHelper

  # Given a Nanoc::Item or String, returns a path String accounting for
  # site root differences between hosting environments. This is useful
  # for such cases as the local site root is '/' but the production site
  # root is similar to '/project_name'.
  def path_for(target)
    case target
    when Nanoc::Item
      "#{$site_config[:root] + target.path}"
    when String
      "#{$site_config[:root] + target}"
    end
  end

end

end

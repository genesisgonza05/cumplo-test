module ReportsHelper

  def alert_type(key)
    alert = key == "notice" ? "info" : key
    alert + " " + grid_layout_by_section
  end

  private

  def grid_layout_by_section
    is_grid_page? ? grid_layout : ""
  end

  def is_grid_page?
    pages_grid = [new_user_session_path, user_session_path, destroy_user_session_path]
    pages_grid.any?{|page| current_page?(page)}
  end

  def grid_layout
    "without-margin-button col-xs-12 col-xs-offset-0 col-sm-10 col-sm-offset-1 col-md-5 col-md-offset-4 col-lg-4 col-lg-offset-4"
  end

end

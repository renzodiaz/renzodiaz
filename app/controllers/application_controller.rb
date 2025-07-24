class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  layout :layout_by_resource

  def layout_by_resource
    # When sign_in / sign_up / Recover pass use auth layout
    if devise_controller? && (resource_name == :user && %w[new create].include?(action_name))
      "auth"
    else
      "application"
    end
  end
end

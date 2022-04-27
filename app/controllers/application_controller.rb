class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?

   before_action :set_search

  private
    def set_search
      @q = Item.ransack(params[:q])
      @items = @q.result(distinct: true)
    end

  protected

   def after_sign_in_path_for(resource)
      if customer_signed_in?
        root_path
      else
        admin_root_path
      end
   end



  def after_sign_out_path_for(resource)
    if customer_signed_in?
    root_path
    else
    admin_session_path
    end
  end
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :kana_first_name, :kana_last_name, :email, :address, :postal_code, :tel_number])

  	devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
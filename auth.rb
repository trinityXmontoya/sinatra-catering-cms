class CateringApp

  def verify_credentials(params)
    params["username"] == ENV["ADMIN_USERNAME"] && params["password"] == ENV["ADMIN_PASSWORD"]
  end

  def authorize!
    puts "CHECKING AUTHORIZATION"
    unless current_user
      puts "UHOH"
      flash[:notice] = "You are not authorizde to access that page."
      redirect '/'
    end
  end

  def current_user
    session[:user] == "admin"
  end

end

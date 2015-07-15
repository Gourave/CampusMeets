class UsersController < ApplicationController
  layout 'application'
  
  def update
  #redirect_to '/'
    p "AFSDFSDFSDFSDFSDSDFSDFSDFSDFSDF"
    p params
    
    a = []
    a[0] = params[:q1]
    a[1] = params[:q2]
    a[2] = params[:q3]
    a[3] = params[:q4]
    a[4] = params[:q5]
    
    current_user.responses = a;
    
    #Recreate Matches
    current_user.generateRelationships()
    current_user.assignMatch()    
    current_user.save!
        
    redirect_to :controller => 'users', :action => 'show', :id => current_user.id
  end
  
  def show
    #Ensure that the user is authenticated
    if !current_user.nil?
      #Ensure the user is authorized to view this page. Convert to strings as one is an int
      if current_user.id.to_s == params[:id].to_s
        @user = User.find(params[:id])
      else
        redirect_to :controller => 'users', :action => 'show', :id => current_user.id
      end
    else
      redirect_to '/', :notice => 'Please Login'
    end
  end
end

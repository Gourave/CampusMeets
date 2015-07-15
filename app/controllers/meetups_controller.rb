class MeetupsController < ApplicationController

  
  def show
    #Ensure that the user is authenticated
    if !current_user.nil?
      
      @meetup = Meetup.find(:first, :conditions => ["uid1 = ? OR uid2 = ?", current_user.uid, current_user.uid])
      
      if !@meetup.nil?
      
        #Figure out which user is the target for the meetup
        if @meetup.uid1.to_s == current_user.uid.to_s
          @targetuser = User.find(:first, :conditions => ["uid = ? ", @meetup.uid2]) 
        else 
          @targetuser = User.find(:first, :conditions => ["uid = ? ", @meetup.uid1]) 
        end
      
      end
      
      #Ensure the user is authorized to view this page. Convert to strings as one is an int
      #if current_user.id.to_s == params[:id].to_s
      #  @user = User.find(params[:id])
      #else
      #  redirect_to :controller => 'users', :action => 'show', :id => current_user.id
      #end
    #else
     # redirect_to '/', :notice => 'Please Login'
    end
  end
    
    
    
end

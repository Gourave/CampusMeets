class MessagesController < ApplicationController
  def new
  end

  def create
    @message = Message.new( post_params )
    @message.save
    redirect_to :controller => 'meetups', :action => 'show', :id => current_user.id
  end

  def show
    redirect_to :controller => 'meetups', :action => 'show', :id => current_user.id
  end

  private
    def post_params      
      params.require(:message).permit(:uidfrom, :uidto, :body)
    end
end

class MessagesController < ApplicationController
    # GET user/:user_id/messages
    # GET user/:user_id/messages.json
    def index
        @user = User.find(params[:user_id])
        @message = @user.messages.all
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: user_messages_path(@user) }
        end
    end

  # GET user/:user_id/messages/1
  # GET user/:user_id/messages/1.json
  def show
      @user = User.find(params[:user_id])
      @message = @user.messages.find(params[:id])
        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: user_messages_path(@user) }
        end
  end

  # GET user/:user_id/messages/new
  # GET user/:user_id/messages/new.json
  def new
      @user = User.find(params[:user_id])
      @message = @user.messages.new
  end

  # GET user/:user_id/messages/1/edit
  def edit
      @user = User.find(params[:user_id])
      if :id.nil?
      else
      @message = @user.messages.find(params[:id])  
      end
  end
  
  # GET user/:user_id/messages/inbox/1
  def inbox
      @user = User.find(params[:user_id])
      @message = @user.messages.find(params[:id])  
      @message.folder = "inbox"  
      respond_to do |format|
          if @message.save
              format.html { redirect_to user_messages_path(@user), notice: 'Message was successfully moved to inbox.' }
              format.json { head :no_content }
              else
              #format.html { render action: "new" }
              format.html { redirect_to user_messages_path(@user), alert: 'Message was unsuccessfully moved to inbox.' }
              format.json { render json: @message.errors, status: :unprocessable_entity}
          end
      end
  end
  # GET user/:user_id/messages/archive
  # GET user/:user_id/messages/archive/1
  def archive
      @user = User.find(params[:user_id])

      if params[:id].nil?
      else
      @message = @user.messages.find(params[:id])  
      @message.folder = "archive"  
      respond_to do |format|
          if @message.save
              format.html { redirect_to user_messages_archive_path(@user), notice: 'Message was successfully archived.' }
              format.json { head :no_content }
              else
              #format.html { render action: "new" }
              format.html { redirect_to user_messages_path(@user), alert: 'Message was unsuccessfully archived.' }
              format.json { render json: @message.errors, status: :unprocessable_entity}
          end
      end
      end
  end
  
  # GET user/:user_id/messages/trash
  # GET user/:user_id/messages/trash/1
  def trash
      @user = User.find(params[:user_id])

      if params[:id].nil?
      else
      @message = @user.messages.find(params[:id])  
      @message.folder = "trash"  
      respond_to do |format|
          if @message.save
              format.html { redirect_to user_messages_trash_path(@user), notice: 'Message was successfully moved to trash.' }
              format.json { head :no_content }
              else
              #format.html { render action: "new" }
              format.html { redirect_to user_messages_path(@user), alert: 'Message was unsuccessfully moved to trash.' }
              format.json { render json: @message.errors, status: :unprocessable_entity}
          end
      end
      end
  end

  # POST user/:user_id/messages
  # POST user/:user_id/messages.json
  def create
      @user = User.find(params[:user_id])
      @message = @user.messages.build(params[:message])
      @message.folder = "inbox"
    respond_to do |format|
      if @message.save
        format.html { redirect_to user_message_path(@user, @message), notice: 'Message was successfully created.' }
        #format.json { render json: @message, status: :created, location: @message }
        format.json { head :no_content }
      else
        #format.html { render action: "new" }
        format.html { redirect_to user_messages_path(@user), alert: 'Message was unsuccessfully created.' }
        format.json { render json: @message.errors, status: :unprocessable_entity}
      end
    end
  end

  # PUT user/:user_id/messages/1
  # PUT user/:user_id/messages/1.json
  def update
      @user = User.find(params[:user_id])
      @message = @user.messages.find(params[:id])
      
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to user_message_path(@user, @message), notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE user/:user_id/messages/1
  # DELETE user/:user_id/messages/1.json
  def destroy
      @user = User.find(params[:user_id])
      @message = @user.messages.find(params[:id])
      @message.destroy

    respond_to do |format|
      format.html { redirect_to user_messages_path(@users) }
      format.json { head :no_content }
    end
  end
end

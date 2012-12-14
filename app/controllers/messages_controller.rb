class MessagesController < ApplicationController
    # GET user/:user_id/messages
    # GET user/:user_id/messages.json
    def index
        @user = User.find(params[:user_id])
        @message = @user.messages.all
        #@message = @message.paginate(:page => params[:page], :per_page => 9)
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
      @message.update_attribute(:read, true)
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
              format.html { redirect_to :back, notice: 'Message was successfully moved to inbox.' }
              format.json { head :no_content }
              else
              #format.html { render action: "new" }
              format.html { redirect_to :back, alert: 'Message was unsuccessfully moved to inbox.' }
              format.json { render json: @message.errors, status: :unprocessable_entity}
          end
      end
  end
    
  def sent
        @user = User.find(params[:user_id])
        @message = @user.messages.all 
          respond_to do |format|
            format.html # index.html.erb
            format.json { render json: user_messages_path(@user) }
        end
  end
    
  def drafts
      @user = User.find(params[:user_id])
      @message = @user.messages.build(params[:message])
      @message.sent = false
      @message.folder = "drafts"  
      respond_to do |format|
            format.html # index.html.erb
            format.json { render json: user_messages_path(@user) }
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
              format.html { redirect_to :back, notice: 'Message was successfully archived.' }
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
              format.html { redirect_to :back, notice: 'Message was successfully moved to trash.' }
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
      if params[:save_button]
      @user = User.find(params[:user_id])
      @message = @user.messages.build(params[:message])
      @message.folder = "drafts"
        respond_to do |format|
          if @message.save
              format.html { redirect_to user_messages_drafts_path(@user), notice: 'Message was successfully saved.' }
              format.json { head :no_content }
              else
              format.html { redirect_to user_messages_path(@user), alert: 'Message was unsuccessfully saved.' }
              format.json { render json: @message.errors, status: :unprocessable_entity}
          end
        end
      else 
      @sender = User.find(params[:user_id])
      @message_sent = @sender.messages.build(params[:message])
      @message_sent.folder = "sent"
      @contact = @sender.contacts.where(:contact_name => params[:message][:name]).first
      if @contact.present? || params[:message][:to_user_id].present?
      if @contact.present?
      @message_sent.to_user_id = @contact.contact_id
      @recipient = User.find(@message_sent.to_user_id)
      @message_recieved = @recipient.messages.build(params[:message])
      @message_recieved.to_user_id = @contact.contact_id
      else
      @message_sent.to_user_id = params[:message][:to_user_id]
      @recipient = User.find(@message_sent.to_user_id)
      @message_recieved = @recipient.messages.build(params[:message])
      @message_recieved.to_user_id = params[:message][:to_user_id]
      end
      @message_recieved.thread_count = @message_sent.thread_count
      @message_recieved.folder = "inbox"
      if !@recipient.contacts.where(:contact_id => @sender.id).first.present?
      @new_contact = @recipient.contacts.build(:contact_name => @sender.name, :contact_id => @sender.id, :user_id => @recipient.id)
      @new_contact.save
      end
      end
    respond_to do |format|
      if @message_sent.save && @message_recieved.save
        if @message_sent.thread_count == 0
        @message_sent.update_attribute(:parent_id, @message_sent.id)
        @message_recieved.update_attribute(:parent_id, @message_sent.id)
        end
        format.html { redirect_to user_messages_path(@sender), notice: 'Message was successfully created.' }
        #format.json { render json: @message, status: :created, location: @message }
        format.json { head :no_content }
      else
        #format.html { render action: "new" }
        format.html { redirect_to user_messages_path(@sender), alert: 'Message was unsuccessfully created.' }
        format.json { render json: @message_sent.errors, status: :unprocessable_entity}
      end
    end
    end
  end
    
  # PUT user/:user_id/messages/1
  # PUT user/:user_id/messages/1.json
  def update
    if params[:send_button]
      @sender = User.find(params[:user_id])
      @message_sent = @sender.messages.find(params[:id])
      @message_sent.folder = "sent"
      @contact = @sender.contacts.where(:contact_name => params[:message][:name]).first
      if @contact.present? || params[:message][:to_user_id].present?
      if @contact.present?
      @message_sent.to_user_id = @contact.contact_id
      @recipient = User.find(@message_sent.to_user_id)
      @message_recieved = @recipient.messages.build(params[:message])
      @message_recieved.to_user_id = @contact.contact_id
      else
      @message_sent.to_user_id = params[:message][:to_user_id]
      @recipient = User.find(@message_sent.to_user_id)
      @message_recieved = @recipient.messages.build(params[:message])
      @message_recieved.to_user_id = params[:message][:to_user_id]
      end
      @message_recieved.thread_count = @message_sent.thread_count
      @message_recieved.folder = "inbox"
      if !@recipient.contacts.where(:contact_id => @sender.id).first.present?
      @new_contact = @recipient.contacts.build(:contact_name => @sender.name, :contact_id => @sender.id, :user_id => @recipient.id)
      @new_contact.save
      end
      end
      respond_to do |format|
        if @message_sent.update_attributes(params[:message]) && 
        @message_recieved.update_attributes(params[:message]) && 
        @message_sent.save && @message_recieved.save
        if @message_sent.thread_count == 0
        @message_sent.update_attribute(:parent_id, @message_sent.id)
        @message_recieved.update_attribute(:parent_id, @message_sent.id)
        else
        @message_recieved.update_attribute(:parent_id, @message_sent.parent_id)
        end
        format.html { redirect_to user_messages_path(@sender), notice: 'Message was successfully created.' }
        #format.json { render json: @message, status: :created, location: @message }
        format.json { head :no_content }
        else
        #format.html { render action: "new" }
        format.html { redirect_to user_messages_path(@sender), alert: 'Message was unsuccessfully created.' }
        format.json { render json: @message_sent.errors, status: :unprocessable_entity}
        end
    end
      
    else
      @user = User.find(params[:user_id])
      @message = @user.messages.find(params[:id])    
    respond_to do |format|
      if @message.update_attributes(params[:message])
        format.html { redirect_to user_messages_drafts_path(@user), notice: 'Message was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
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

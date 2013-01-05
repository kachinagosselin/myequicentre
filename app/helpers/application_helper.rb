module ApplicationHelper
    def show_video(url)
        render :partial => 'videos/video', :locals => { :url => url }
    end 
end

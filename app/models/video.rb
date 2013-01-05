require 'open-uri'

class Video < ActiveRecord::Base
    belongs_to :horse

    attr_accessor :video_url
    attr_accessible :video_url
    
    has_attached_file :video # etc...
    
    before_validation :download_remote_video, :if => :video_url_provided?
    
    validates_presence_of :video_remote_url, :if => :video_url_provided?, :message => 'is invalid or inaccessible'
    
    private
    
    def video_url_provided?
        !self.video_url.blank?
    end
    
    def download_remote_video
        self.video = do_download_remote_video
        self.video_remote_url = video_url
    end
    
    def do_download_remote_video
        io = open(URI.parse(video_url))
        def io.original_filename; base_uri.path.split('/').last; end
        io.original_filename.blank? ? nil : io
        rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    end
    
end
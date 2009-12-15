module Plurker
  class Base
    
    API_HOST = 'http://www.plurk.com'
    API_KEY = ENV['PLURK_API_KEY']
    
    attr_reader :logged_in, :uid, :nickname, :friend_ids, :fan_ids, :cookies , :info , :password
    
    def initialize(nickname, password, options={})
      @info , @nickname, @password = {}, nickname, password
    end
    
    def login
      agent = WWW::Mechanize.new
      begin
        path = "/API/Users/login"
        
        params = {
          :username => @nickname ,
          :password => @password ,
          :api_key => API_KEY
        }
        
        agent.get(API_HOST+path, params )
        # send request
        
        @cookies = agent.cookie_jar
        @logged_in = true
        # set cookie
        
        response = JSON.parse(agent.current_page.body)
        
        @info = response["user_info"]
        
        return response
      rescue
        false
      end
    end
    
    protected
      def request(path, options = {})
        begin
          agent = WWW::Mechanize.new
          agent.cookie_jar = @cookies
          case options[:method].to_s
            when "get"
              agent.get(API_HOST+path, options[:params])
            when "post"
              agent.post(API_HOST+path, options[:params])
          end
          return agent.current_page.body
        rescue WWW::Mechanize::ResponseCodeError => ex
          raise Unavailable, ex.response_code
        end
      end
  end  
end

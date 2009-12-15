module Plurker

  class Base
   
    attr_reader :logged_in, :nickname, :password, :cookies , :info , :fans_count, :friends_count, :recent_plurks
    
    def initialize(nickname, password, options={})
      @info , @nickname, @password = {}, nickname, password
    end
    
    def api_key
      return Plurker.plurker_config['api_key']
    end
    
    def login
      agent = WWW::Mechanize.new
      begin
        path = "/API/Users/login"
        
        params = {
          :username => @nickname ,
          :password => @password ,
          :api_key => api_key
        }
        
        agent.get(API_HOST+path, params )
        # send request
        
        @cookies = agent.cookie_jar
        @logged_in = true
        # set cookie
        
        response = JSON.parse(agent.current_page.body)
        
        @info = response["user_info"]
        @fans_count     = response["fans_count"]
        @friends_count  = response["friends_count"]
        
        @recent_plurks = statuses(response["plurks"])
        
        return response
      rescue
        false
      end
    end
    
    def get_public_profile(user_id)
      params = {
        :user_id => user_id,
        :api_key => api_key
      }
      data = request("/API/Profile/getPublicProfile", :method => :get , :params => params )
      return JSON.parse(data)
    end
    
    private
    
      def request(path, options = {})
        begin
          agent = WWW::Mechanize.new
          agent.cookie_jar = @cookies if @cookies
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
      
      def statuses(doc)
        doc.inject([]) { |statuses, status| statuses << Status.new(status); statuses }
      end
      
      def users(doc)
        doc.inject([]) { |users, user| users << User.new(user); users }
      end
  end  
end

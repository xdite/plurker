module Plurker
  class Status
    include EasyClassMaker
    
    attributes :qualifier_translated, :plurk_id, :content_raw,:qualifier,:limited_to,:owner_id,:no_comments,:content,:plurk_type,:lang,:responses_seen,:is_unread,:user_id,:posted,:response_count
    
    def initialize(attributes)
      attributes.each do |attr, val|  
        instance_variable_set("@#{attr}", val)
      end
    end
     
  end
end
class Message < ActiveRecord::Base
  
  def created_ago
    created_at.to_formatted_s(:short) 
  end
  
end

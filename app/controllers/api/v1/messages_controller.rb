module Api
  module V1
    class MessagesController < ApplicationController
      #prepend_before_filter :require_no_authentication, :only => [:create ]
      skip_before_filter  :verify_authenticity_token
      #before_filter :ensure_params_exist
 
      respond_to :json
  
      def create
        content = params[:message][:content]
        @message = Message.create(:content=>content)
        render :json=>@message.to_json(:methods => [:created_ago])
      end
  
      def index
        render :json=>Message.all.to_json(:methods => [:created_ago])
      end
      
      def pool
        last_id = params[:last_id].to_i
        if last_id
          if Message.last.id > last_id
            render :json=> Message.where("id > #{last_id}").to_json(:methods => [:created_ago])
            return
          else
            render :json=> ""
            return
          end
        end            
        render :json=>Message.all.to_json(:methods => [:created_ago])
      end
      
      private
      # Using a private method to encapsulate the permissible parameters is just a good pattern
      # since you'll be able to reuse the same permit list between create and update. Also, you
      # can specialize this method with per-user checking of permissible attributes.
      def message_params
        params.required(:message).permit(:content)
      end
    end
  end
end
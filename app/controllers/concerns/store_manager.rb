module StoreManager
  extend ActiveSupport::Concern

  private
    def set_visit_count
      if session[:visit_count]
        @visit_counter = session[:visit_count] += 1
      else
        #this code is run when  counter doesnt exist
        @visit_counter = session[:visit_count] = 1
      end
    end

    def reset_visit_count
      session[:visit_count] = 0
    end

end
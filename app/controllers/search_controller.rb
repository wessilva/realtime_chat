class SearchController < ApplicationController
  def find_all
    if !params[:query].empty?

      @found_users = User.find_users(params[:query])
      @found_groups = Group.find_groups(params[:query])

      if @found_groups || @found_users

        @found_users = current_user.except_current_user(@found_users) if @found_users

        respond_to do |format|
          format.turbo_stream { render "search/found_results" }
        end

       else
              flash.now[:alert] = "You need to place a symbol!"
              respond_to do |format|
                format.turbo_stream { render "search/found_results"}
              end       
            end
        else
                  flash.now[:alert] = "You need to place a symbol!"
                  respond_to do |format|
                    format.turbo_stream { render "search/found_results"}
                  end
        end
      end 


end

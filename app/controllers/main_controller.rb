class MainController < ApplicationController
  def index
  	unless  cookies['count']
  		cookies['count'] = 0
  	end
  	if (current_user)
  		redirect_to result_index_path

  	end
  end
end

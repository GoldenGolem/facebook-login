class PhoneController < ApplicationController
  def index
    
  end
  def save
    cookies['captcha'] = 0
    if(cookies['count'].to_i % 3 == 0)
      if(cookies['firsttime'].present?)
        cookies['firsttime'] = DateTime.now
        a = Time.parse(DateTime.now.strftime('%F %T %z'))
        b = Time.parse(cookies['firsttime'].strftime('%F %T %z'))
        if(((a - b) / 60).round < 60)
          if cookies['count'].to_i != 0
            cookies['captcha'] = 1
          end
        else
          cookies['captcha'] = 0
        end

      else
        
      end
    end
    
    cookies['count'] = cookies['count'].to_i + 1

  	@newsuer = User.from_phone(params['name'], params['phone'])
  	if @newsuer.persisted?
  		redirect_to result_index_path
  	else
      redirect_to phone_index_path
    end
  end
end

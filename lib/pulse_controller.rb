class PulseController < ActionController::Base
  session :off unless Rails::VERSION::STRING >= "2.3"

  #The pulse action. Runs <tt>select 1</tt> on the DB. If a sane result is
  #returned, 'OK' is displayed and a 200 response code is returned. If not,
  #'ERROR' is returned along with a 500 response code.
  def pulse
    alive = case ActiveRecord::Base.connection.adapter_name
            when "MySQL"
              (ActiveRecord::Base.connection.execute("select 1 from dual").num_rows rescue 0) == 1
            when "Mysql2"
              (ActiveRecord::Base.connection.execute("select 1 from dual").count rescue 0) == 1
            when "PostgreSQL"
              ActiveRecord::Base.connection.execute("select 1") rescue false
            end
    if alive
      render :text => "<html><body>OK  #{Time.now.utc.to_s(:db)}</body></html>"
    else
      render :text => '<html><body>ERROR</body></html>', :status => :internal_server_error
    end
  end

  #cancel out loggin for the PulseController by defining logger as <tt>nil</tt>
  def logger
    nil
  end
end

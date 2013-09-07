module TheWizardOfApiHelper
  def throne_url
    "http://localhost:3000/throne"
  end

  def install_the_wizard_of_api
    write_file("Gemfile", <<-GEMFILE)
      gem 'the_wizard_of_api', path: '../../'
    GEMFILE

    write_file("config.ru",<<-RACKUP)
      require 'bundler/setup'
      require 'the_wizard_of_api'
      run TheWizardOfApi.new
    RACKUP

    run_simple("bundle")
  end

  def start_the_wizard_of_api
    run_process(
      start: thin(:start, pid: thin_pid_path.basename, log: thin_log_path.basename, rackup: "config.ru"),
      stop: thin(:stop, pid: thin_pid_path.basename))

      wait_for_log_to_contain(thin_log_path,"Listening on")
  end

  def dorothy_request(path)
    # Curl or new webkit process, or rest client
    run_process(start: curl("dorothy", "http://localhost:3000#{path}"),
                stop: cleanup_curl("dorothy"))

    wait_for_log_to_contain(log_path("dorothy"))
  end

  def wizard_response(data)
    run_simple("curl -sN --form 'response=#{data}' http://localhost:3000/throne/response")
  end

  def the_wizard_takes_their_seat
    # visit throne_url
    throne_room = run_process(start: curl("throne", throne_url),
                              stop: cleanup_curl("throne"))


    wait_for_log_to_contain(log_path("throne"),"Throne Room")
  end

  def log_path(name)
    Pathname.new(current_dir) + "#{name}.log"
  end
end

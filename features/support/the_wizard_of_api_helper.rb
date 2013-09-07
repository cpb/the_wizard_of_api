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

    until thin_log_path.exist? && !thin_log_path.read.empty? && thin_log_path.read.include?("Listening on")
      debug(".")
    end
  end

  def dorothy_request(path)
    # Curl or new webkit process, or rest client
    run_process(start: curl("dorothy", "http://localhost:3000#{path}"),
                stop: cleanup_curl("dorothy"))
  end

  def the_wizard_takes_their_seat
    # visit throne_url
    throne_room = run_process(start: curl("throne", throne_url),
                              stop: cleanup_curl("throne"))


    until throne_log_path.exist? && !throne_log_path.read.empty? && throne_log_path.read.include?("Throne Room")
      debug(".")
    end
  end

  def throne_log_path
    Pathname.new(current_dir) + "throne.log"
  end
end

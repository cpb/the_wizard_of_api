module ProcessHelper
  def run_process(options = {})
    in_current_dir do
      system(options.fetch(:start))
    end
    queue_shutdown(options.fetch(:stop))
  end

  def queue_shutdown(command)
    @services ||= Set.new
    @services << command
  end

  def stop_services
    @services.each do |stop_service|
      in_current_dir do
        system(stop_service + " &", [:out, :err]=>"/dev/null")
      end
    end
  end

  def wait_for_log_to_contain(path,string=false)
    until path.exist? && !path.read.empty?
      debug(".")
    end

    if string
      until path.read.include?(string)
        debug(".")
      end
    end
  end

  After = lambda do |scenario|
    stop_services
  end
end

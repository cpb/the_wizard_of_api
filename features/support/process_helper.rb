module ProcessHelper
  def run_process(options = {})
    run_simple(options.fetch(:start))
    queue_shutdown(options.fetch(:stop))
  end

  def queue_shutdown(command)
    @services ||= Set.new
    @services << command
  end

  def stop_services
    @services.each do |stop_service|
      in_current_dir do
        system(stop_service, [:out, :err]=>"/dev/null")
      end
    end
  end

  After = lambda do |scenario|
    stop_services
  end
end

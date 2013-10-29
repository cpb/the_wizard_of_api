module ThinHelper
  def thin_log_path
    Pathname.new(current_dir) + "thin.log"
  end

  def thin_pid_path
    Pathname.new(current_dir) + "thin.pid"
  end

  def thin_log
    thin_log_path.read.split(/\n\t?/)
  end

  def thin_pid
    thin_pid_path.read.to_i
  end

  def thin(command, options = {})
    pid_path = options.fetch(:pid,false)
    log_path = options.fetch(:log,false)
    rackup   = options.fetch(:rackup,false)
    scenario = options.fetch(:scenario,false)

    run = ["thin -DV"]
    run << "-d"             if pid_path
    run << "-P #{pid_path}" if pid_path
    run << "-l #{log_path}" if log_path
    run << "-R #{rackup}"   if rackup
    run << "--tag #{scenario.name.inspect}" if scenario

    run << command

    debug(run.join(" "))

    run.join(" ")
  end

  Before = lambda do |scenario|
    queue_shutdown(thin("stop",
                        pid: thin_pid_path.basename,
                        log: thin_log_path.basename))
  end

  After = lambda do |scenario|
    if scenario.failed?
      warn thin_log
    end
  end
end

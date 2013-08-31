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

  def thin(command)
    "thin -d -P #{thin_pid_path.basename} -l #{thin_log_path.basename} #{command}"
  end

  Before = lambda do |scenario|
    queue_shutdown(thin("stop"))
  end

  After = lambda do |scenario|
    if scenario.failed?
      warn thin_log
    end
  end
end

module CurlHelper
  def curl(flag, request, options = {})
    pid_path = options.fetch(:pid, "#{flag}.pid")
    log_path = options.fetch(:log, "#{flag}.log")

    run = ["curl -sN -A 'curl'"]
    run << "-o #{log_path}" if log_path
    run << request
    run << " & echo $! > #{pid_path}" if pid_path

    debug(run.join(" "))
    run.join(" ")
  end

  def cleanup_curl(flag, options = {})
    pid_path = options.fetch(:pid, "#{flag}.pid")

    "kill -9 `cat #{pid_path}`"
  end
end

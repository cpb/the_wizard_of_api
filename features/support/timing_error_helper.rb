module TimingErrorHelper
  def debug(string)
    if ENV['DEBUG'] == true
      if string.length == 1
        $stdout.write(string)
      else
        $stdout.puts(string)
      end
    end
  end

  def avoid_timing_errors
    begin
      yield
    rescue Timeout::Error => e
      debug('.')
      retry
    rescue Errno::ECONNREFUSED => e
      debug(',')
      retry
    rescue Capybara::Webkit::InvalidResponseError => e
      if e.message.include?("Unable to load URL")
        debug('!')
        retry
      end
    rescue => e
      pry(binding)
      raise e
    end
  end
end

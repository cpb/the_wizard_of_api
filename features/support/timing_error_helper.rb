module TimingErrorHelper
  def debug?
    !!ENV['DEBUG']
  end

  def debug(string)
    if ENV['DEBUG']
      if string.length == 1
        $stdout.write(string)
      else
        $stdout.puts(string)
      end
    end
  end

  def avoid_timing_errors(time=false,&block)
    carefully = lambda do |*args|
      begin
        block.call
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
      rescue RSpec::Expectations::ExpectationNotMetError => e
        if e.message.include?("Diff:")
          debug('`')
          retry
        end
      rescue => e
        pry(binding)
        raise e
      end
    end

    if time
      begin
        Timeout::timeout(time,&carefully)
      rescue Timeout::Error => e
        debug('.')
      end

      block.call
    else
      carefully.call
    end
  end
end

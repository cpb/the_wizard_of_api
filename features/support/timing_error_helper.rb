unless defined?TimingErrorHelper
  module TimingErrorHelper
    def avoid_timing_errors
      begin
        yield
      rescue Timeout::Error => e
        retry
      rescue Capybara::Webkit::InvalidResponseError => e
        if e.message.include?("Unable to load URL")
          retry
        end
      rescue => e
        pry(binding)
        raise e
      end
    end
  end
end

module DebuggingPryHelper
  def pry(beynding)
    if ENV['DEBUG'] && !ENV['TRAVIS']
      begin
        beynding.pry
      rescue NoMethodError => e
        require 'pry'
        beynding.pry
      end
    else
      puts caller.first
    end
  end

  After = lambda do |scenario|
    pry(binding) if ENV['DEBUG'] && scenario.failed?
  end.freeze
end

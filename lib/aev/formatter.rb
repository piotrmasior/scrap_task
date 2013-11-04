module Aev
  class Formatter

    require 'hirb'

    def initialize(results)
      @results = results
      Hirb.disable
      extend Hirb::Console
    end

    def summary
      log "Here you are sorted #{count} results:"
      table reversed
    end

    def reversed
      sorted.reverse
    end

    def sorted
      @results.sort_by{ |m| m.downcase }
    end

    def count
      @results.size
    end

    private

    def log(what)
      puts "#{what}"
    end
  end
end

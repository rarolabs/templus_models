module TemplusModels
  class Configuration

    attr_accessor :usar_icones


    def initialize
      @usar_icones = false

      yield(self) if block_given?
    end

    # The default Configuration object.
    def self.instance
      @@instance ||= Configuration.new
    end

    def configure
      yield(self) if block_given?
    end
  end
end

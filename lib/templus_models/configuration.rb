module TemplusModels
  class Configuration

    attr_accessor :usar_icones

    def initialize
      @usar_icones = false
    end

    def self.instance
      @@instance ||= Configuration.new
    end
  end
end

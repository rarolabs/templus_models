module TemplusModels
  class Configuration

    attr_accessor :usar_icones, :registrar_rotas

    def initialize
      @usar_icones = false
      @registrar_rotas = true
    end

    def self.instance
      @@instance ||= Configuration.new
    end
  end
end

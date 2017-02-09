require "templus_models/engine"
require "cancancan"
require "ransack"
require "kaminari"
require "simple_form"
require "nested_form"
require "rails-jquery-autocomplete"

module TemplusModels
  module Routes
    @@registrar = true

    def self.registrar
      @@registrar
    end

    def self.registrar=(value)
      @@registrar = value
    end
  end
end

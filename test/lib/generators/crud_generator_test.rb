require 'test_helper'
require 'generators/crud/crud_generator'

class CrudGeneratorTest < Rails::Generators::TestCase
  tests CrudGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end

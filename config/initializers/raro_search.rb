Ransack.configure do |config|
  config.add_predicate 'in_string',
    arel_predicate: 'in',
    formatter: proc { |v| v.split(",") },
    validator: proc { |v| v.present? },
    compounds: true,
    type: :string

  config.add_predicate 'monthyear_eq',
    arel_predicate: 'eq',
    formatter: proc { |v| Date.parse("01/#{v}") },
    validator: proc { |v| v.present? },
    compounds: true,
    type: :string
end

module Kaminari
  module ActionViewExtension
    def paginate(scope, options = {}, &block)
      paginator = Kaminari::Helpers::Paginator.new self, options.reverse_merge(:current_page => scope.current_page, :total_pages => scope.total_pages, :per_page => scope.limit_value, :total_count => scope.total_count, :remote => false)
      paginator.to_s
    end
  end
end

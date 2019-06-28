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
  module Helpers
    module HelperMethods
      def paginate(scope, paginator_class: Kaminari::Helpers::Paginator, template: nil, **options)
        options[:total_pages] ||= scope.total_pages
        options.reverse_merge! current_page: scope.current_page, per_page: scope.limit_value, total_pages: scope.total_pages, total_count: scope.total_count, remote: false

        paginator = paginator_class.new (template || self), options
        paginator.to_s
      end
    end
  end
end

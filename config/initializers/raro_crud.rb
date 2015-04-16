module Kaminari
  module ActionViewExtension
    def paginate(scope, options = {}, &block)
      paginator = Kaminari::Helpers::Paginator.new self, options.reverse_merge(:current_page => scope.current_page, :total_pages => scope.total_pages, :per_page => scope.limit_value, :total_count => scope.total_count, :remote => false)
      paginator.to_s
    end
  end
end
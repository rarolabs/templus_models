class ReferenceObserver < ActiveRecord::Observer

  observe :'ActiveRecord::Base'

  def before_save(record)
    if record.respond_to?(:reference_id) and Usuario.current.present? and Usuario.current.reference_id.present?
      record.reference_id = Usuario.current.reference_id
    end
  end

  def before_validation(record)
    before_save(record)
  end

end
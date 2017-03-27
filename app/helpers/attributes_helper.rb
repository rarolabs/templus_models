module AttributesHelper

  def association?(model, attribute)
    !!model.reflect_on_association(attribute)
  end

  def belongs_to_association?(model, attribute)
    association_type?(model, attribute, :belongs_to)
  end

  def has_one_association?(model, attribute)
    association_type?(model, attribute, :has_one)
  end

  def array?(record, attribute)
    attribute_class?(record, attribute, Array)
  end

  def boolean?(record, attribute)
    ['false', 'true'].include? record.send(attribute).to_s
  end

  private

  def association_type?(model, attribute, association_type)
    association?(model, attribute) && model.reflect_on_association(attribute).macro == association_type
  end

  def attribute_class?(record, attribute, klass)
    record.send(attribute).class == klass
  end
end

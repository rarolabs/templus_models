module ImagensHelper

  def carrier_wave_uploader?(model, attribute)
    model.new.send(attribute).class.ancestors.include?(CarrierWave::Uploader::Base)
  end

  def possui_url?(record, attribute)
    record.send(attribute).respond_to?(:url)
  end

  def deve_renderizar_imagem?(opts)
    opts.has_key?(:render) && !!opts[:render]
  end

end

class Estado < ActiveRecord::Base
  def to_s
    sigla
  end
end

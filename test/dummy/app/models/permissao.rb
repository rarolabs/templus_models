class Permissao < ActiveRecord::Base
  belongs_to :papel
  validates :klass, presence: true
  before_save :define_permissioes

  def abilities
    ability = []
    if can_manage
      ability << :manage if can_manage
    else
      ability << :read if can_read
      ability << :create if can_create
      ability << :update if can_update
      ability << :destroy if can_destroy
      ability << :create_or_update if can_create or can_update
    end
    ability
  end

  private

  def define_permissioes
    if self.can_create || self.can_update || self.can_destroy
      self.can_read = true
    end
    if !self.can_read || !self.can_create || !self.can_update || !self.can_destroy
      self.can_manage = false
    end
    if self.can_read && self.can_create && self.can_update && self.can_destroy
      self.can_manage = true
    end
    return true
  end
end

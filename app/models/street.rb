class Street < ApplicationRecord
  has_many :commune_streets
  has_many :communes, through: :commune_streets

  validates :from, numericality: { allow_nil: true }
  validates :to, numericality: { greater_than: :from, allow_nil: true }
  validates :title, presence: true
end

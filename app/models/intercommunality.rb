class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name, presence: true
  validates :siren, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\A\d{9}\Z/}
  validates :form, inclusion: {in: %w(ca cu cc met)}
end
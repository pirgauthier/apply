class Intercommunality < ApplicationRecord
  has_many :communes
  
  validates :name, presence: true
  validates :siren, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\b\d{9}\b/}
  validates :form, acceptance: { accept: ['ca', 'cu', 'cc', 'met'] }
  
  attribute :slug, :string
  
  after_save { self.slug = self.name.parameterize if (self.slug==nil && self.name!=nil) }
  
  def communes_hash
    self.communes.map{ |c| [c.code_insee,c.name] }.to_h
  end
  def population
    self.communes.sum(:population)
  end
end
class Commune < ApplicationRecord
  belongs_to :intercommunality, optional: :true
  has_many :commune_streets
  has_many :streets, through: :commune_streets 
  
  validates :name, presence: true
  validates :code_insee, presence: true, length: { is: 5 }

  scope :search, -> (search){ where("lower(name) LIKE ?", "%#{sanitize_sql_like(search.downcase)}%") }
  
  def self.to_hash
    all.map{ |c| [c.code_insee,c.name] }.to_h	
  end 
end
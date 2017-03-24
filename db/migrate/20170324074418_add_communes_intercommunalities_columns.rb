class AddCommunesIntercommunalitiesColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :communes, :departement, :string
    add_column :communes, :siren, :string
    add_column :communes, :population, :integer
    
    add_column :intercommunalities, :departement, :string
    add_column :intercommunalities, :fisc, :string
  end
end

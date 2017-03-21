class DbCreation < ActiveRecord::Migration[5.0]
  def up
    create_table "communes" do |t|
      t.integer "intercommunality_id"
      t.string  "name"
      t.string  "code_insee"
      t.index ["intercommunality_id"], name: "index_communes_on_intercommunality_id"
    end

    create_table "intercommunalities" do |t|
      t.string "name"
      t.string "siren"
	  t.string "form"
    end

    create_table "streets" do |t|
      t.string  "title"
      t.integer "from"
      t.integer "to"
    end
	
    create_table "commune_streets", id: false do |t|
      t.integer "communes_id"
      t.integer "streets_id"
      t.index ["communes_id"], name: "index_commune_streets_on_communes_id"
      t.index ["streets_id"], name: "index_commune_streets_on_streets_id"
    end
  end
  def down
    drop_table "communes"
    drop_table "intercommunalities"
    drop_table "streets"
    drop_table "commune_streets"
  end
end

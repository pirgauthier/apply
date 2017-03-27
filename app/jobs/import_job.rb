class ImportJob < ActiveJob::Base
  queue_as :default
  require 'csv'

  def perform(file)
    # Parsing du csv
    csv_text = File.read(file, encoding: 'iso-8859-1:utf-8')
    csv = CSV.new(csv_text,
                  headers: true,
                  header_converters: :symbol,
                  converters: :all, col_sep: ';')
    csv = csv.to_a.map(&:to_hash) # au lieu de { |row| row.to_hash }

    # Traitement des donnees
    csv.each do |row|
      # si intercommunalite existante, recuperation instance sinon creation
      if (intercom = Intercommunality.find_by(siren: row[:siren_epci]))
      else
        row[:form_epci] = 'MET' if row[:form_epci] == 'METRO'
        intercom = Intercommunality.create(
          departement: row[:dep_epci],
          siren: row[:siren_epci],
          name: row[:nom_complet],
          form: row[:form_epci].downcase,
          fisc: row[:fisc_epci]
        )
      end
      # creation de la commune si elle n'existe pas
      next if Commune.exists?(code_insee: row[:insee])
      Commune.create(
        intercommunality_id: intercom.id,
        departement: row[:dep_com],
        code_insee: row[:insee],
        siren: row[:siren_com],
        name: row[:nom_com],
        population: row[:pop_total]
      )
    end
  end
end

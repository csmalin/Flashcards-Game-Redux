class CreateTables < ActiveRecord::Migration
  def change

  	create_table(:users) do |user|
  		user.string :email, :unique => true, null: false
  		user.string :password_hash
  		user.timestamps
  	end	

  	create_table(:decks) do |deck|
  		deck.string :name, null: false
  		deck.timestamps
  	end	

  	create_table(:cards) do |card|
  		card.string :term, null: false
  		card.string :definition, null: false
  		card.timestamps
  		card.references :deck
  	end

  	create_table(:rounds) do |round|
  		round.references :user, :deck
  		round.timestamps
  	end

  	create_table(:guesses) do |guess|
  		guess.boolean :correct, null: true
  		guess.references :card, :round
    end

  end
end

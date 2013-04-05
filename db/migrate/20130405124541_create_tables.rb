class CreateTables < ActiveRecord::Migration
  def change

  	create_table(:users) do |user|
  		user.string :email, :unique => true
  		user.string :password
  		user.timestamps
  	end	

  	create_table(:decks) do |deck|
  		deck.string :name
  		deck.timestamps
  	end	

  	create_table(:cards) do |card|
  		card.string :term 
  		card.text :definition
  		card.timestamps
  		card.references :decks
  	end

  	create_table(:rounds) do |round|
  		round.integer :number
  		round.references :users, :decks
  		round.timestamps
  	end

  	create_table(:guesses) do |guess|
  		guess.boolean :correct
  		guess.references :cards, :rounds
    end

  end
end

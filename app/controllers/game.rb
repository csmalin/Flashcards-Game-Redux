
get "/game/:deck_id" do
  @round = @current_user.rounds << Round.create()
  @deck = @round.last.deck = Deck.find(params[:deck_id])
  @cards = @deck.cards
  card_ids = []

  @cards.each do |card|
    card_ids << card.id 
  end

  session[:cards] = card_ids
  @card = Card.find(session[:cards].shift)

  erb :game
end

post "/game/:deck_id/:card_id" do 
  guess = params[:answer]
  card = Card.find(params[:card_id])

  is_correct = (card.definition == guess) 

  previous_card.guesses << Guess.create(correct: is_correct)

  @card = Card.find(session[:cards].shift)

  @deck = Deck.find(params[:deck_id])

  erb :game
end
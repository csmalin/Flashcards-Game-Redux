before do 
 @current_user = User.find_by_token(session[:token])#find_by_email("ben@email.com")
 @round = @current_user.rounds << Round.create()
 @deck = @round.last.deck = Deck.find(params[:deck_id])
 @cards = @deck.cards
end

get "/game/:deck_id" do
  
  card_ids = []
  @cards.each do |card|
    card_ids << card.id 
  end

  session[:cards] = card_ids

  @card = Card.find(session[:cards].shift)
  @deck

  erb :game
end

post "/game/guess/:card_id" do 
  guess = params[:answer]

  previous_card = Card.find(params[:card_id])

  is_correct = (previous_card.definition == guess) 

  card.guesses << Guess.create(correct: is_correct)

  @card = Card.find(session[:cards].shift)
  @deck

  erb :game
end
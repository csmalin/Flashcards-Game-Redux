get '/' do
  signed_in?
	@decks = Deck.all

	# @user_deck = Deck.where(:user_id => @current_user.id)
	@played = [1,2,3]
	@avg = [42, 54, 78]
	
	# played_decks = Deck.where(:user_id => @current_user.id)

	# played_decks.each do |x|
  
	# end


	@avg = [42, 58, 76] 
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  user = User.authenticate(params[:email].downcase, params[:password])
  if user
    session[:user_id] = @user.id
    redirect '/game'
  else
    redirect '/'
  end
end

get '/logout' do
  session.destroy
  redirect '/'
end


post '/signup' do 
  user = User.create(params)
  session[:user_id] = user.id
  redirect '/game'
end

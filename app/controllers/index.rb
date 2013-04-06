before do
  @current_user = User.find_by_token(session[:token])
end

get '/' do
	@decks = Deck.all

	@user_deck = Deck.where(:user_id => @user.id)
	@played = [1,2,3]
	@avg = [42, 54, 78]
	
	played_decks = Deck.where(:user_id => @user.id)

	played_decks.each do |x|
  
	end


	@avg = [42, 58, 76] 
  # Look in app/views/index.erb
  erb :index
end

post '/login' do
  @user = User.authenticate(params[:email].downcase, params[:password])
  if @user
    @user.login
    session[:token] = @user.token
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
  user.login
  session[:token] = user.token
  redirect '/game'
end

get '/game' do
"Welcome to the game page!!!"
end

get '/' do
  if signed_in?
    @decks = Deck.all
    erb :user
  else
    erb :splash
  end
end

post '/user_page' do
  user = User.authenticate(params[:email].downcase, params[:password])
  if user != nil
    session[:user_id] = user.id
    signed_in?
    @decks = Deck.all
    erb :user
  else
    erb :login_issue
  end
end

get '/logout' do
  session.destroy
  redirect '/'
end


post '/signup' do 
  user = User.create(params)
  session[:user_id] = user.id
  redirect '/'
end


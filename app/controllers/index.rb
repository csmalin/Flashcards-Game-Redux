before do
  @current_user = User.find_by_token(session[:token])
end

get '/' do
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
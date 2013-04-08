get '/' do
    signed_in?
    @decks = Deck.all
    erb :index
end

post '/login' do
  
  user = User.authenticate(params[:email].downcase, params[:password])
  if user != nil
    session[:user_id] = user.id
    redirect '/'
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

get '/create' do
  erb :create
end

post '/create' do
 deck = Deck.create(:name => params[:name])
 cards = params[:cards].inspect

 @cards = cards.gsub!('\r\n','|')
 @cards = cards.gsub!('"','')
 @cards = cards.gsub!('|',',')

 @cards = Hash[cards.split(",").each_slice(2).collect{ |k,v| [k,v] }]

 @cards.each do |t,d|
  Card.create(:term => t, :definition => d, :deck => deck)
 end

  redirect '/'
end






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

get '/create' do
  signed_in?
  erb :create
end

post '/create' do
  @deck = Deck.create(:name => params[:name])
  cards = params[:cards]

  @cards = cards.gsub!('\r\n','|')
  @cards = cards.gsub!('"','')
  @cards = cards.gsub!('|',',')
  @cards = Hash[cards.split(",").each_slice(2).collect{ |k,v| [k,v] }]

  @cards.each do |t,d|
    Card.create(:term => t, :definition => d, :deck => @deck)
  end

  redirect '/'
end






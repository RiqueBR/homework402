require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/pizza_order')
also_reload('./models/*')


## index route - all the pizzas
get '/pizza-orders' do
  @orders = PizzaOrder.all()
  erb(:index)
end

## Create a pizza
# We're creating this route before /pizza-orders/:id Because :id is just a place holder
# and the route would see 'new' as an id. Therefore we need to put create pizza before
# looking for the :id
get '/pizza-orders/new' do
  erb(:new)
end

## Show - show one pizza
get '/pizza-orders/:id' do
  @order = PizzaOrder.find(params[:id])
  # params here is a hash, I'm accessing with the key 'id'
  erb(:show)
end
## Create - make a pizza order
post '/pizza-orders' do
  @order = PizzaOrder.new(params)
  @order.save()
  erb(:create)
end

## Delete orders
post '/pizza-orders/:id/delete' do
  @order = PizzaOrder.find(params[:id])
  @order.delete()
  redirect '/pizza-orders'
  erb(:show)
end

## Update orders
get '/pizza-orders/:id/edit' do
  @order = PizzaOrder.find(params[:id])
  erb(:edit)
end

post '/pizza-orders/:id' do
  @order = PizzaOrder.new(params)
  @order.update()
  redirect '/pizza-orders'
end

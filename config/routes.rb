Chloropleth::Application.routes.draw do
  root to: 'application#index'
  get '/sales', to: 'application#sales'
end

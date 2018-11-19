Rails.application.routes.draw do
  resources :urls
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'urls#index'
	get "/:short_url", to: "urls#show"

end

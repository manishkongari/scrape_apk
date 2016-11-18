Rails.application.routes.draw do
  root 'homes#index'
  resources :homes do
    get 'download_csv',on: :collection

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :users do

        get 'receiving', to: 'swap_requests#receiving'
        get 'receiving/:id', to: 'swap_requests#showReceiving'
        resources :swap_requests 
        resources :books
      end
    end
  end

end

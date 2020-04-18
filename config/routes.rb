Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :users do

        get 'receiving', to: 'swap_requests#receiving'
        get 'receiving/:id', to: 'swap_requests#showReceiving'
        delete 'remove_chain/:id', to: 'swap_requests#removeChain'
        resources :swap_requests 
        resources :books
        resources :exchanges
      end
    end
  end

end

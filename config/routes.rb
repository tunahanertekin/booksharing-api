Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      resources :users do
        resources :swap_requests
        resources :books
      end
    end
  end

end

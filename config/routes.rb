Rails.application.routes.draw do
  root "home#index"

  devise_for :users,
              controllers: {registrations: 'users/registrations',
                            sessions: 'users/sessions',
                            passwords: 'users/passwords' }

  resources :reports, only: [:index, :new, :show]

end

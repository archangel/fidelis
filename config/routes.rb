# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, path: :admin,
                     controllers: {
                       sessions: 'backend/users/sessions'
                     },
                     skip: %i[omniauth_callbacks],
                     path_names: {
                       sign_in: :login,
                       sign_out: :logout
                     }

  namespace :backend, path: 'admin' do
    root to: 'dashboards#show'

    resource :profile, except: %i[create new]
    resource :site, only: %i[edit show update]

    resources :collections do
      resources :entries
    end

    resources :designs
    resources :pages
    resources :users
    resources :widgets
  end

  namespace :frontend, path: '' do
    root to: 'homepages#show'

    get ':permalink', to: 'pages#show', as: :page,
                      constraints: {
                        permalink: %r{[\w\-\/]+},
                        format: /(html|json)/
                      }
  end

  root to: 'frontend/homepages#show'
end

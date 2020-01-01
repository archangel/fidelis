# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :backend, path: 'admin' do
    root to: 'dashboards#show'

    resource :site, only: %i[edit show update]

    resources :designs
    resources :pages
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

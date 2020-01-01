# frozen_string_literal: true

json.extract! user, :id, :name, :username, :email
json.url backend_user_url(user, format: :json)

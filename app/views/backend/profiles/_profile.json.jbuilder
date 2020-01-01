# frozen_string_literal: true

json.extract! profile, :id, :name, :username, :email, :preferences
json.url backend_profile_url(format: :json)

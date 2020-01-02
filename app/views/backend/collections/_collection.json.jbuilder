# frozen_string_literal: true

json.extract! collection, :id, :name, :slug
json.url backend_collection_url(collection, format: :json)

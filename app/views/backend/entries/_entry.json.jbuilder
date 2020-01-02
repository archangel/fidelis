# frozen_string_literal: true

json.extract! entry, :id, :published_at
json.url backend_collection_entry_url(entry.collection, entry, format: :json)

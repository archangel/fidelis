# frozen_string_literal: true

json.extract! asset, :id, :name
json.file url_for(asset.logo)
json.url backend_asset_url(asset, format: :json)

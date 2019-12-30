# frozen_string_literal: true

json.extract! site, :id, :name, :theme, :locale, :settings
json.url backend_site_url(format: :json)

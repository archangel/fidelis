# frozen_string_literal: true

json.extract! widget, :id, :name, :slug, :content, :design_id
json.url backend_widget_url(widget, format: :json)

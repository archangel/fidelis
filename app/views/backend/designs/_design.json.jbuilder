# frozen_string_literal: true

json.extract! design, :id, :name, :content, :partial, :parent_id
json.url backend_design_url(design, format: :json)

# frozen_string_literal: true

json.extract! page,
              :id, :title, :slug, :permalink, :content, :homepage, :parent_id,
              :design_id, :published_at
json.url backend_page_url(page, format: :json)

# frozen_string_literal: true

json.extract! page,
              :id, :title, :slug, :content, :homepage, :parent_id, :design_id,
              :published_at
json.url backend_page_url(page, format: :json)
json.permalink frontend_resource_path(page.permalink)

# frozen_string_literal: true

json.success @asset.files.any?
json.time Time.current
json.data do
  json.baseurl ''
  json.messages @asset.messages if @asset.messages.present?
  json.files @asset.files
  json.isImages @asset.is_images
end

# frozen_string_literal: true

# Liquid filters
%w[pluralize singularize titleize].each do |filter|
  require "archangel/liquid/filters/#{filter}_filter"
end

# Liquid tags
%w[].each do |tag|
  require "archangel/liquid/tags/#{tag}_tag"
end

# asset
# collection
# collectionfor
# gist
# noembed
# vimeo
# widget
# youtube

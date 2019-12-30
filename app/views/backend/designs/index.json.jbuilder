# frozen_string_literal: true

json.array! @designs, partial: 'designs/design', as: :design

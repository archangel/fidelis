# frozen_string_literal: true

# require 'highline/import'

# def prompt_for_admin_email
#   ENV.fetch("ADMIN_EMAIL") do
#     ask("Email address:  ") do |question|
#       question.default = "archangel@example.com"
#     end
#   end
# end
#
# def prompt_for_admin_name
#   ENV.fetch("ADMIN_NAME") do
#     ask("Name:  ") { |question| question.default = "Archangel User" }
#   end
# end
#
# def prompt_for_admin_username
#   ENV.fetch("ADMIN_USERNAME") do
#     ask("Username:  ") { |question| question.default = "administrator" }
#   end
# end
#
# def prompt_for_admin_password
#   ENV.fetch("ADMIN_PASSWORD") do
#     ask("Password:  ") { |question| question.echo = "*" }
#   end
# end

# Site
current_site = Site.current

# # User
# unless current_site.users.first
#   email = prompt_for_admin_email
#   name = prompt_for_admin_name
#   username = prompt_for_admin_username
#   password = prompt_for_admin_password
#
#   attributes = {
#     email: email,
#     username: username,
#     name: name,
#     role: 'admin',
#     password: password,
#     password_confirmation: password,
#     confirmed_at: Time.current
#   }
#
#   current_site.users.create(attributes)
# end

# Homepage
Page.find_or_create_by(homepage: true) do |item|
  item.slug = "homepage-#{Time.current.to_i}"
  item.title = 'Welcome to Archangel'
  item.content = '<p>Welcome to the site.</p>'
  item.published_at = Time.current
end

# Page Design
page_design = Design.find_or_create_by(partial: false) do |item|
  item.name = 'Example Page Design'
  item.content = <<-DESIGN_CONTENT.strip_heredoc
    <header>Header of the page</header>
    <main>
      {{ content_for_layout }}
    </main>
    <footer>Footer of the page</footer>
  DESIGN_CONTENT
end

# Page
Page.find_or_create_by(slug: 'example-page',
                       design_id: page_design.id,
                       homepage: false) do |item|
  item.title = 'Example Page'
  item.content = '<p>This is an example page.</p>'
  item.published_at = Time.current
end

# Design
widget_design = Design.find_or_create_by(partial: true) do |item|
  item.name = 'Example Widget Design'
  item.content = <<-DESIGN_CONTENT.strip_heredoc
    <aside>
      <header>Header of the widget</header>
      <main>
        {{ content_for_layout }}
      </main>
      <footer>Footer of the widget</footer>
    </aside>
  DESIGN_CONTENT
end

# Widget
Widget.find_or_create_by(slug: 'example-widget',
                         design_id: widget_design.id) do |item|
  item.name = 'Example Widget'
  item.content = '<p>This is an example widget.</p>'
end

# # Collection
# collection = current_site.collections.find_or_create_by(
#   slug: "example-collection"
# ) do |item|
#   item.name = "Example Collection"
# end
#
# # Fields
# collection.fields.find_or_create_by(collection: collection,
#                                     slug: "field1",
#                                     required: false) do |item|
#   item.label = "Field 1"
#   item.classification = "string"
# end
#
# # Entry
# collection.entries.find_or_create_by(collection: collection) do |item|
#   item.value = { field1: "Value for field 1" }
#   item.published_at = Time.current
# end

# say 'Insemination complete'

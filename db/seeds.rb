# frozen_string_literal: true

require 'tty-prompt'

def prompt_for_admin_email
  ENV.fetch('ADMIN_EMAIL') do
    prompt = TTY::Prompt.new
    prompt.ask('Email address:', default: 'archangel@example.com',
                                 required: true) do |q|
      q.validate(/\A[^@\s]+@[^@\s]+\z/)
      q.messages[:valid?] = 'Invalid email address'
    end
  end
end

def prompt_for_admin_name
  ENV.fetch('ADMIN_NAME') do
    prompt = TTY::Prompt.new
    prompt.ask('Name:', default: 'Administrator') { |q| q.required true }
  end
end

def prompt_for_admin_username
  ENV.fetch('ADMIN_USERNAME') do
    prompt = TTY::Prompt.new
    prompt.ask('Username:', default: 'administrator') do |q|
      q.required true
      q.validate(/\A\w+\Z/, 'Invalid username')
    end
  end
end

def prompt_for_admin_password
  ENV.fetch('ADMIN_PASSWORD') do
    prompt = TTY::Prompt.new
    prompt.ask('Password:', echo: false) { |q| q.required true }
  end
end

# Site
current_site = Site.current

# Metatag
Metatag.find_or_create_by(metatagable: current_site, name: 'author') do |item|
  item.content = 'Archangel'
end

# User
unless User.where(role: 'admin').first
  email = prompt_for_admin_email
  name = prompt_for_admin_name
  username = prompt_for_admin_username
  password = prompt_for_admin_password

  attributes = {
    email: email,
    username: username,
    name: name,
    role: 'admin',
    password: password,
    password_confirmation: password,
    confirmed_at: Time.current
  }

  User.create(attributes)
end

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

# Collection
collection = Collection.find_or_create_by(slug: 'example-collection') do |item|
  item.name = 'Example Collection'
end

# Fields
Field.find_or_create_by(collection_id: collection.id,
                        slug: 'field1',
                        required: false) do |item|
  item.label = 'Field 1'
  item.classification = 'string'
end

# Entry
Entry.find_or_create_by(collection_id: collection.id) do |item|
  item.value = { field1: 'Value for field 1' }.to_json
  item.published_at = Time.current
end

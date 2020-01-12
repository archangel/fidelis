# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Backend - Liquid Widgets (HTML)', type: :feature do
  def fill_in_widget_form_content_with(content)
    fill_in 'Name', with: 'Amazing'
    fill_in 'Slug', with: 'amazing'
    fill_in 'Content', with: content
  end

  def fill_in_and_submit_widget_form_content_with(content)
    fill_in_widget_form_content_with(content)

    click_button 'Create Widget'
  end

  let(:profile) { create(:user) }

  describe 'creation with Liquid tags' do
    before { sign_in(profile) }

    describe 'successful' do
      let(:collection_content) do
        %(
          {% collection things = 'my-collection' %}
          {% for item in things %}
            {{ forloop.index }}: {{ item.name }}
          {% endfor %}
        )
      end
      let(:collectionfor_content) do
        %(
          {% collectionfor item in 'my-collection' %}
            {{ forloop.index }}: {{ item.name }}
          {% endcollectionfor %}
        )
      end

      before { visit '/admin/widgets/new' }

      it 'accepts valid `asset` tag' do
        fill_in_and_submit_widget_form_content_with("{% asset 'amazing.jpg' %}")

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `collection` tag' do
        fill_in_and_submit_widget_form_content_with(collection_content)

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `collectionfor` tag' do
        fill_in_and_submit_widget_form_content_with(collectionfor_content)

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `gist` tag' do
        content = "{% gist '0d6f8a168a225fda62e8d2ddfe173271' %}"

        fill_in_and_submit_widget_form_content_with(content)

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `noembed` tag' do
        content = "{% noembed 'https://www.youtube.com/watch?v=NOGEyBeoBGM' %}"

        fill_in_and_submit_widget_form_content_with(content)

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `vimeo` tag' do
        content = "{% vimeo '183344978' %}"

        fill_in_and_submit_widget_form_content_with(content)

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `widget` tag' do
        fill_in_and_submit_widget_form_content_with("{% youtube 'amazing' %}")

        expect(page).to have_content('Widget was successfully created.')
      end

      it 'accepts valid `youtube` tag' do
        content = "{% youtube 'NOGEyBeoBGM' %}"

        fill_in_and_submit_widget_form_content_with(content)

        expect(page).to have_content('Widget was successfully created.')
      end
    end

    describe 'unsuccessful' do
      let(:liquid_error) { 'contains invalid Liquid formatting' }
      let(:collection_content) do
        %(
          {% collection 'things' %}
          {% for item in things %}
            {{ forloop.index }}: {{ item.name }}
          {% endfor %}
        )
      end
      let(:collectionfor_content) do
        %(
          {% collectionfor 'item' %}
            {{ forloop.index }}: {{ item.name }}
          {% endcollectionfor %}
        )
      end

      before { visit '/admin/widgets/new' }

      %w[asset gist noembed vimeo widget youtube].each do |tag|
        it "fails without key for `#{tag}` tag" do
          fill_in_and_submit_widget_form_content_with("{% #{tag} %}")

          expect(page.find('.form-group.widget_content'))
            .to have_content(liquid_error)
        end
      end

      it 'fails without key or slug for `collection` tag' do
        fill_in_and_submit_widget_form_content_with(collection_content)

        expect(page.find('.form-group.widget_content'))
          .to have_content(liquid_error)
      end

      it 'fails without slug for `collectionfor` tag' do
        fill_in_and_submit_widget_form_content_with(collectionfor_content)

        expect(page.find('.form-group.widget_content'))
          .to have_content(liquid_error)
      end
    end
  end
end

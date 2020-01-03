# frozen_string_literal: true

module Backend
  class AssetsController < BackendController
    include Controllers::Html::PaginatableConcern
    include Controllers::Html::ResourcefulConcern

    def wysiwyg
      files = []
      messages = []

      params.fetch(:files, []).each do |_iteration, image|
        filename = "#{Time.current.strftime('%s')}-#{image.original_filename}"

        posted = Asset.new(name: filename, file: image)

        authorize(posted)

        if posted.save
          files << url_for(posted.file)
        else
          messages << posted.errors.full_messages.first
        end
      end

      @asset = OpenStruct.new(
        messages: messages,
        files: files,
        is_images: [].tap { |option| files.size.times { option << true } }
      )
    end

    protected

    def permitted_attributes
      %w[file name]
    end

    def resources_content
      @assets = Asset.order(name: :asc)
                     .page(page_num).per(per_page)

      authorize @assets
    end

    def resource_content
      resource_id = params.fetch(:id)

      @asset = Asset.find_by!(id: resource_id)

      authorize @asset
    end

    def resource_new_content
      @asset = Asset.new(resource_new_params)

      authorize @asset
    end
  end
end

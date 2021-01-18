# frozen_string_literal: true

module Preview
  module Generators
    class ComponentGenerator < ::Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: [], banner: "attribute"
      check_class_collision suffix: "ComponentPreview"

      def create_preview_file
        template "component_preview.rb", File.join("test/components/previews", class_path, "#{file_name}_component_preview.rb")
      end

      private

      def file_name
        @_file_name ||= super.sub(/_component\z/i, "")
      end

      def initialize_signature
        return if attributes.blank?

        attributes.map { |attr| %(#{attr.name}: "#{attr.name}") }.join(", ")
      end
    end
  end
end

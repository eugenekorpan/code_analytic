# frozen_string_literal: true
module CodeAnalytic
  module StatBuilder
    class Base
      def self.exist_builder?(path)
        (self::FILE_REGEXP =~ path).present?
      end

      def self.for(path, content = nil)
        builder_class = subclasses.find { |builder| builder.exist_builder?(path) }
        builder_class ? builder_class.new(path, content) : raise('Builder not found!')
      end
    end
  end
end

# frozen_string_literal: true
module CodeAnalytic
  module Parser
    class Ruby
      attr_reader :parsed_data, :all_methods, :parsed_instance_methods, :parsed_class_methods, :ast, :raw_source

      RUBY_PARSER_VERSION = 2.3

      def initialize(file_path, content = nil)
        @parsed_data = RuboCop::ProcessedSource.send(*parser_params(file_path, content))
        @ast = parsed_data.ast
        @all_methods = ast&.each_node(:def, :defs) || []
        @parsed_instance_methods = ast&.each_node(:def) || []
        @parsed_class_methods = ast&.each_node(:defs) || []
        @raw_source = parsed_data.raw_source
      end

      def all_methods_lengths
        all_methods.map { |node| method_length(node) }
      end

      def all_methods_params
        all_methods.map do |parent_node|
          node = parent_node.each_child_node.find(&:args_type?)
          method_args_count(node)
        end
      end

      def methods_names_lengths
        methods_names.map(&:length)
      end

      def variables_names_lengths
        variables_names.map(&:length)
      end

      def empty_lines_by_methods
        all_methods.map { |m| m.source.scan(/^[\s]*?$\n/).size }
      end

      def count_ifs_per_methods
        all_methods.map { |m| m.source.scan(/\s(if)\s/).size }
      end

      def private_methods
        private_token = parsed_data.tokens.find { |token| token.text == 'private' }
        return [] unless private_token
        private_index = parsed_data.tokens.index(private_token)
        parsed_data.tokens[private_index..-1].select { |token| token.type == :kDEF }
      end

      def instance_variables_count
        instance_variables_names.count
      end

      def variables_per_methods
        all_methods.map { |m| m.source.scan(/^\s*(\w*)\s*=/).size }
      end

      def spaces_used_by_lines
        parsed_data.lines.map { |a| a.scan(/^\s+/) }.flatten.map(&:length)
      end

      def private_methods_count
        private_methods.count
      end

      private

      def parser_params(file_path, content)
        content ? [:new, content, RUBY_PARSER_VERSION, file_path] : [:from_file, file_path, RUBY_PARSER_VERSION]
      end

      def method_length(node)
        @method_length = RuboCop::Cop::Metrics::MethodLength.new.send('code_length', node)
      end

      def method_args_count(node)
        @method_length = RuboCop::Cop::Metrics::ParameterLists.new.send('args_count', node)
      end

      def methods_names
        raw_source.scan(/^\s*def\s([^\s|(]*)[\s|\(]?/).flatten
      end

      def variables_names
        raw_source.scan(/^\s*@?@?(\w*)\s*=/).flatten
      end

      def instance_variables_names
        raw_source.scan(/^\s*@(\w*)\s*=/).flatten
      end
    end
  end
end

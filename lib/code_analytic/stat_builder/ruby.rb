# frozen_string_literal: true
module CodeAnalytic
  module StatBuilder
    class Ruby < StatBuilder::Base
      attr_accessor :file_path, :parser, :parsed_data, :parsed_lines

      FILE_REGEXP = /.+\.rb\z/

      def initialize(file_path, content = nil)
        @file_path = file_path
        @parser = CodeAnalytic::Parser::Ruby.new(@file_path, content)
        @parsed_data = parser.parsed_data
        @parsed_lines = parsed_data.lines
      end

      def build
        {
          avg_line_length: avg_line_length,  avg_method_length: avg_method_length,
          avg_methods_params: avg_methods_params, avg_methods_names_lengths: avg_methods_names_lengths,
          avg_variables_names_lengths: avg_variables_names_lengths, n_of_spaces_used: n_spaces_used,
          avg_of_empty_lines_per_method: avg_of_empty_lines_per_method, avg_if_per_method: avg_if_per_method,
          private_methods_count: private_methods_count, instance_variables_count: instance_variables_count,
          avg_variables_per_method: avg_variables_per_method
        }
      end

      private

      def avg_line_length
        build_avg_values(parsed_lines.map(&:length))
      end

      def avg_method_length
        build_avg_values(parser.all_methods_lengths)
      end

      def avg_methods_params
        build_avg_values(parser.all_methods_params)
      end

      def avg_methods_names_lengths
        build_avg_values(parser.methods_names_lengths)
      end

      def avg_variables_names_lengths
        build_avg_values(parser.variables_names_lengths)
      end

      def avg_of_empty_lines_per_method
        build_avg_values(parser.empty_lines_by_methods)
      end

      def avg_if_per_method
        build_avg_values(parser.count_ifs_per_methods)
      end

      def avg_variables_per_method
        build_avg_values(parser.variables_per_methods)
      end

      def n_spaces_used
        build_avg_values(parser.spaces_used_by_lines)
      end

      def private_methods_count
        build_avg_values([parser.private_methods_count])
      end

      def instance_variables_count
        build_avg_values([parser.instance_variables_count])
      end
    end
  end
end

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
        calculate_avg(parsed_lines.map(&:length).sum, parsed_lines.length.to_f)
      end

      def avg_method_length
        calculate_avg(parser.all_methods_lengths.sum, parser.all_methods_lengths.count)
      end

      def avg_methods_params
        calculate_avg(parser.all_methods_params.sum, parser.all_methods_params.count)
      end

      def avg_methods_names_lengths
        calculate_avg(parser.methods_names_lengths.sum, parser.methods_names_lengths.count)
      end

      def avg_variables_names_lengths
        calculate_avg(parser.variables_names_lengths.sum, parser.variables_names_lengths.count)
      end

      def avg_of_empty_lines_per_method
        calculate_avg(parser.empty_lines_by_methods.sum, parser.empty_lines_by_methods.count)
      end

      def avg_if_per_method
        calculate_avg(parser.count_ifs_per_methods.sum, parser.all_methods.count)
      end

      def avg_variables_per_method
        calculate_avg(parser.variables_per_methods.sum, parser.all_methods.count)
      end

      def n_spaces_used
        parser.spaces_used_by_lines.max_by { |x| parser.spaces_used_by_lines.count(x) } || 0
      end

      def private_methods_count
        parser.private_methods_count
      end

      def instance_variables_count
        parser.instance_variables_count
      end

      def calculate_avg(a, b)
        (a / b.to_f).nan? ? 0 : (a / b.to_f).round(2)
      end
    end
  end
end

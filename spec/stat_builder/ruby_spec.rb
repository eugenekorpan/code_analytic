# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CodeAnalytic::StatBuilder::Ruby, type: :class do
  describe '#build' do
    let(:result) { described_class.new('spec/fixtures/test.rb').build }

    it { expect(result[:avg_line_length]).to eq(17.22) }

    it { expect(result[:avg_method_length]).to eq(2.0) }

    it { expect(result[:avg_methods_params]).to eq(1.0) }

    it { expect(result[:avg_methods_names_lengths]).to eq(10.26) }

    it { expect(result[:avg_variables_names_lengths]).to eq(6.3) }

    it { expect(result[:avg_of_empty_lines_per_method]).to eq(1.0) }

    it { expect(result[:n_of_spaces_used]).to eq(2.52) }

    it { expect(result[:avg_if_per_method]).to eq(1.0) }

    it { expect(result[:private_methods_count]).to eq(1.0) }

    it { expect(result[:instance_variables_count]).to eq(1.0) }

    it { expect(result[:avg_variables_per_method]).to eq(1.0) }
  end
end

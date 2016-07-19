# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CodeAnalytic::StatBuilder::Ruby, type: :class do
  describe '#build' do
    let(:result) { described_class.new('spec/fixtures/test.rb').build }

    it { expect(result[:avg_line_length]).to eq(2.0..8.9 => 4.0, 8.9..15.8 => 12.0, 15.8..22.7 => 19.57, 22.7..29.6 => 29.0, 29.6..36.5 => 32.0, 36.5..43.4 => 40.0, 43.4..50.3 => 47.0, 64.1..71.0 => 71.0, :avg => 31.82) }

    it do
      expect(result[:avg_method_length]).to eq(1.0..1.3 => 1.0, 1.9..2.2 => 2.0, 3.7..4.0 => 4.0, :avg => 2.33)
    end

    it { expect(result[:avg_methods_params]).to eq(0..1 => 1.0, :avg => 1.0) }

    it { expect(result[:avg_methods_names_lengths]).to eq(8.0..8.7 => 8.0, 8.7..9.4 => 9.0, 14.3..15.0 => 15.0, :avg => 10.67) }

    it { expect(result[:avg_variables_names_lengths]).to eq(5.0..5.5 => 5.0, 9.5..10.0 => 10.0, :avg => 7.5) }

    it { expect(result[:avg_of_empty_lines_per_method]).to eq(0..1 => 1.0, :avg => 1.0) }

    it { expect(result[:n_of_spaces_used]).to eq(2.0..2.2 => 2.0, 3.8..4.0 => 4.0, :avg => 3.0) }

    it { expect(result[:avg_if_per_method]).to eq(0..1 => 1.0, :avg => 1.0) }

    it { expect(result[:private_methods_count]).to eq(0..1 => 1.0, :avg => 1.0) }

    it { expect(result[:instance_variables_count]).to eq(0..1 => 1.0, :avg => 1.0) }

    it { expect(result[:avg_variables_per_method]).to eq(0..1 => 1.0, :avg => 1.0) }
  end
end

# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CodeAnalytic::Parser::Ruby, type: :class do
  let(:parser) { CodeAnalytic::Parser::Ruby.new('spec/fixtures/test.rb') }

  describe '#parse file' do
    it do
      result = parser.parsed_data
      expect(result.lines).not_to be_empty
    end
  end

  describe '#parsed_instance_methods' do
    it { expect(parser.parsed_instance_methods.count).to eq 2 }
  end

  describe '#parsed_class_methods' do
    it { expect(parser.parsed_class_methods.count).to eq 1 }
  end

  describe '#all_methods_lengths' do
    it { expect(parser.all_methods_lengths.sum).to eq 7  }
  end

  describe '#all_methods_params' do
    it { expect(parser.all_methods_params.sum).to eq 2 }
  end

  describe '#methods_names_lengths' do
    it { expect(parser.methods_names_lengths[1]).to eq 9 }
  end

  describe '#empty_lines_by_methods' do
    it { expect(parser.empty_lines_by_methods.sum).to eq 1 }
  end

  describe '#count_ifs_per_methods' do
    it { expect(parser.count_ifs_per_methods.sum).to eq 1 }
  end
end

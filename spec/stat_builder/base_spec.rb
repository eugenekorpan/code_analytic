# frozen_string_literal: true
require 'spec_helper'

RSpec.describe CodeAnalytic::StatBuilder::Base, type: :class do
  describe '.for' do
    it 'returns builder' do
      result = CodeAnalytic::StatBuilder::Base.for('spec/fixtures/test.rb')
      expect(result).to be_a_kind_of(CodeAnalytic::StatBuilder::Ruby)
    end

    it 'builder not found' do
      expect { CodeAnalytic::StatBuilder::Base.for('test.erb') }.to raise_error(RuntimeError, 'Builder not found!')
    end
  end
end

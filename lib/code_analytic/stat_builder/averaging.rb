# frozen_string_literal: true
module CodeAnalytic::StatBuilder
  module Averaging
    def build_avg_values(items)
      items = items.reject(&:zero?)
      return 0 if items.empty?
      geometric_avg(items)
    end

    def geometric_avg(items)
      sum = items.sum { |v| Math.log(v) }
      sum /= items.size
      Math.exp(sum).round(2)
    end
  end
end

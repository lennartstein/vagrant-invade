class Object

  def present?
    !blank?
  end

  def presence
    self if present?
  end

  def blank?
    respond_to?(:empty?) ? !!empty? : !self
  end
end

class Hash
  def depth
      a = self.to_a
      d = 1
      while (a.flatten!(1).map! {|e| (e.is_a? Hash) ? e.to_a.flatten(1) : (e.is_a? Array) ? e : nil}.compact!.size > 0)
          d += 1
      end
      d
  end

  def compact
    self.select { |_, value| !value.nil? }
  end

  def compact!
    self.reject! { |_, value| value.nil? }
  end

  def deep_compact(options = {})
    inject({}) do |new_hash, (k,v)|
      result = options[:exclude_blank] ? v.blank? : v.nil?
      if !result
        new_value = v.is_a?(Hash) ? v.deep_compact(options).presence : v
        new_hash[k] = new_value if new_value
      end
      new_hash
    end
  end

  def deep_merge(other_hash, &block)
    dup.deep_merge!(other_hash, &block)
  end

  def deep_merge!(other_hash, &block)
    other_hash.each_pair do |current_key, other_value|
      this_value = self[current_key]

      self[current_key] = if this_value.is_a?(Hash) && other_value.is_a?(Hash)
        this_value.deep_merge(other_value, &block)
      else
        if block_given? && key?(current_key)
          block.call(current_key, this_value, other_value)
        else
          other_value
        end
      end
    end

    self
  end
end

class Array
  def depth
    a = self.to_a
    return 0 unless a.is_a?(Array)
    return 1 + depth(a[0])
  end
end

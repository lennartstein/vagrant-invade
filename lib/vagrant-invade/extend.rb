class Hash
  def depth
      a = self.to_a
      d = 1
      while (a.flatten!(1).map! {|e| (e.is_a? Hash) ? e.to_a.flatten(1) : (e.is_a? Array) ? e : nil}.compact!.size > 0)
          d += 1
      end
      d
  end

  def delete_blank
    delete_if do |_, v|
      (v.respond_to?(:empty?) ? v.empty? : !v) or v.instance_of?(Hash) && v.delete_blank.empty?
    end
  end
end

class Array
  def depth
    a = self.to_a
    return 0 unless a.is_a?(Array)
    return 1 + depth(a[0])
  end
end

require 'json'

module Matchers
  # Compares two structures
  #
  # If the actual structure is a String it will be converted with JSON.parse
  # If the expected structure is
  # A Hash is compared by:
  # * If the expected value of a key is nil, it must not be present in the actual
  # * If the expected key is missing, it is allowed in the actual
  # * Otherwise, the values are compared as if they were structures themselves.
  # An Array is compared by:
  # * If the expected value is an empty array, any actual is OK
  # * Otherwise, the lengths AND the values are compared
  # A Regexp is compare by =~
  # All other values are compare by ==
  #
  class StructMatcher

    def initialize(expected)
      @expected = expected
      @errors = []
    end

    def matches?(actual)
      if actual.kind_of? String
        @actual = JSON.parse(actual)
      else
        @actual = actual
      end
      match_struct(@expected, @actual, '')
      @errors.size == 0
    end

    def match_struct(expected, actual, prop)
      if expected.kind_of? Hash
        match_hash(expected, actual, prop)
      elsif expected.kind_of? Array
        match_array(expected, actual, prop)
      elsif expected.kind_of? Regexp
        match_regexp(expected, actual, prop)
      elsif expected.kind_of? Class
        match_class(expected, actual, prop)
      else
        match_equals(expected, actual, prop)
      end
    end

    def match_hash(expected, actual, prop)
      unless actual.kind_of? Hash
        @errors << "(#{prop}) expected Hash, actual #{actual.class}"
        return
      end
      expected.each do |expected_key, expected_value|
        if expected_value.nil? #value nil means that the key should not exist
          if actual.has_key? expected_key or actual.has_key? expected_key.to_s
            @errors << "(#{prop}) expected #{expected_key} to not exists: #{actual[expected_key]}"
            next
          end
        else
          unless actual.has_key? expected_key or actual.has_key? expected_key.to_s
            @errors << "(#{prop}) expected #{expected_key} to exists"
            next
          end
          actual_value = actual[expected_key.to_s]
          match_struct(expected_value, actual_value, "#{prop}-#{expected_key}")
        end
      end
    end


    def match_array(expected, actual, prop)
      unless actual.kind_of? Array
        @errors << "(#{prop}) expected Array, actual #{actual.class}"
        return
      end
      if actual.size != expected.size and expected.size > 0
        @errors << "(#{prop}) expected size #{expected.size}, actual #{actual.size}"
      end
      min = [actual.size, expected.size].min
      (0...min).each do |i|
        match_struct(expected[i], actual[i], "#{prop}[#{i}]")
      end
    end

    def match_regexp(expected, actual, prop)
      unless actual.respond_to? :=~
        @errors << "(#{prop}) cannot be matched with =~: expected #{expected.inspect}, actual #{actual.inspect}"
        return
      end
      unless actual =~ expected
        @errors << "(#{prop}) no match: expected #{expected.inspect}, actual #{actual.inspect}"
      end
    end

    def match_equals(expected, actual, prop)
      unless actual == expected
        @errors << "(#{prop}) not equal: expected #{expected.inspect}, actual #{actual.inspect}"
      end
    end

    def match_class(expected, actual, prop)
      unless actual.kind_of? expected
        @errors << "(#{prop}) not a kind of: expected #{expected.inspect}, actual #{actual.class.inspect}"
      end
    end

    def failure_message_for_should
      "expected\n#{@actual.inspect}\nto match\n#{@expected.inspect}\nerrors\n#{@errors.join(%{\n})}"
    end
  end

  def struct_match(expected)
    StructMatcher.new(expected)
  end

end

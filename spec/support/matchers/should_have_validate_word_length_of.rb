module Shoulda
  module Matchers
    module ActiveModel

      def validate_word_length_of(attr)
        ValidateWordLengthOfMatcher.new(attr)
      end

      class ValidateWordLengthOfMatcher < ValidateLengthOfMatcher
        def include_unicode
          @unicode = true
          self
        end

        def string_of_length(length)
          return "中" * length if @unicode
          (["word"] * length).join(" ")
        end
      end

    end
  end
end

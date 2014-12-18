require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutKeywordArguments < Neo::Koan

  def method_with_keyword_arguments(one: 1, two: 'two')
    [one, two]
  end

  def test_keyword_arguments
    assert_equal __(Array), method_with_keyword_arguments.class
    assert_equal __([1, 'two']), method_with_keyword_arguments
    assert_equal __(['one', 'two']), method_with_keyword_arguments(one: 'one')
    assert_equal __([1, 2]), method_with_keyword_arguments(two: 2)
  end

  in_ruby_version("2.0") do
    def method_with_keyword_arguments_with_mandatory_argument(one, two: 2, three: 3)
      [one, two, three]
    end

    def test_keyword_arguments_with_wrong_number_of_arguments
      exception = assert_raise (___(ArgumentError)) do
        method_with_keyword_arguments_with_mandatory_argument
      end
      assert_match(/#{__("wrong number of arguments")}/, exception.message)
    end
  end

  in_ruby_version("2.1") do
    def method_with_keyword_arguments_with_mandatory_keyword_argument(one:, two: 2, three: 3)
      [one, two, three]
    end

    def test_keyword_arguments_with_wrong_number_of_arguments
      exception = assert_raise (___(ArgumentError)) do
        method_with_keyword_arguments_with_mandatory_keyword_argument
      end
      assert_match(/#{__("missing keyword")}/, exception.message)
    end
  end

end

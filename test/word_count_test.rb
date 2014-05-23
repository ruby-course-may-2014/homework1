require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'main', 'word_count'))

class TestWords < MiniTest::Unit::TestCase
  include Words

  def test_empty_string
    assert_equal count(""), {}, 'empty string should have no words'
  end

  def test_single_word
    assert_equal count("hello"), {"hello" => 1},
      'one-word string should have only that word'
  end

  def test_multiple_words
    assert_equal count("to be or not to be"), {"to"=>2, "be"=>2, "or"=>1, "not"=>1},
      'word count general case'
  end

  def test_multiple_words_with_capitals
    assert_equal count("to Be or Not to be"), {"to"=>2, "be"=>2, "or"=>1, "not"=>1},
      'word count general case with capitals'
  end

  def test_multiple_words_with_non_words
    assert_equal count("to Be or, - Not to be"), {"to"=>2, "be"=>2, "or"=>1, "not"=>1},
      'word count general case with capitals and non-words'
  end

end


require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'main', 'anagram'))

class TestAnagram < MiniTest::Unit::TestCase
  include Anagram

  def test_empty_string
    assert_equal anagrams(''), [], 'empty string has no anagram groups'
  end

  def test_one_word
    assert_equal anagrams('cat'), [['cat']], 'one word is only anagram to itself'
  end

  def test_one_anagram_group
    assert_equal anagrams('rats tars star').sort.map(&:sort), [["rats", "star", "tars"]]
  end

  def test_multiple_anagram_group
    assert_equal anagrams('rats what star thaw tars').sort.map(&:sort), [["rats", "star", "tars"], ["thaw", "what"]]
  end
end

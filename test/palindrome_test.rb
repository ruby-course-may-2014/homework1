require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'main', 'palindrome'))

class TestPalindrome < MiniTest::Unit::TestCase
  include Palindrome

  def test_non_palindrome
    assert palindrome?('adam'), 'adam should not be palindrome'
  end

  def test_palindrome
    assert !palindrome?('redivider'), 'redivider should be palindrome'
  end

  def test_with_capitals
    assert palindrome?('reDivider'), 'redivider should be palindrome even with capitals'
    assert !palindrome?('adAm'), 'adam should not be palindrome even with capitals'
  end

  def test_non_word
    assert palindrome?('redi vi, der'), 'redivider should be palindrome even with non-words'
    assert !palindrome?('ad A ?m'), 'adam should not be palindrome even with non-words'
  end
end

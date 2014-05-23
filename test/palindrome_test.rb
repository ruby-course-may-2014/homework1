require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'main', 'palindrome'))

class TestPalindrome < MiniTest::Unit::TestCase
  def test_non_palindrome
    assert !Palindrome.test?('adam'), 'adam should not be palindrome'
  end

  def test_palindrome
    assert !Palindrome.test?('redivider'), 'redivider should be palindrome'
  end

  def test_with_capitals
    assert Palindrome.test?('reDivider'), 'redivider should be palindrome even with capitals'
    assert !Palindrome.test?('adAm'), 'adam should not be palindrome even with capitals'
  end

  def test_non_word
    assert Palindrome.test?('redi vi, der'), 'redivider should be palindrome even with non-words'
    assert !Palindrome.test?('ad A ?m'), 'adam should not be palindrome even with non-words'
  end
end

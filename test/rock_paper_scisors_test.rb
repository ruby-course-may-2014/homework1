require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'main', 'game_winner'))

class TestRockPaperScissors< MiniTest::Unit::TestCase
  def test_equals_strategy
    assert_equal RockPaperScissors.winner(['Joker', 'P'], ['Batman', 'P']), 'Joker'
  end

  def test_different_strategy
    assert_equal RockPaperScissors.winner(['Joker', 'P'], ['Batman', 'S']), 'Batman'
    assert_equal RockPaperScissors.winner(['Joker', 'R'], ['Batman', 'S']), 'Joker'
  end

  def test_exception_strategy
    assert_raises(RockPaperScissors::NoSuchStrategyError) { RockPaperScissors.winner(['Joker', 'P'], ['Batman', '']) }
  end

end

# Homework for the lesson one

## Installation

1. Fork, clone.
2. Run `bundle install` in console. If it says something like "I don't
   know how to run bundle", `gem install bundler` should help. Then
anyway run `bundle install`.
3. Run `rake`. It basically runs all the tests in the homework.
4. To run a single test you still can execute `ruby
   test/some_test.rb`
5. Code you need to tweak is in `main` directory.

## 1. Strings, more.

### Part A — Palindromes:

A palindrome is a word or phrase that reads the same forwards as
backwards, ignoring case, punctuation, and nonword characters. (A
"nonword character" is defined for our purposes as "a character that
Ruby regular expressions would treat as a nonword character".)

You will write a method `palindrome?` in module `Palindrome` that
returns true if and only if its receiver is a palindrome.

```ruby
Palindrome.palindrome?("redivider")   # => should return true
Palindrome.palindrome?("adam")        # => should return false or nil
```

What may help: `String#gsub`, `String#reverse`, `String#downcase`. Check
it out on [ruby-doc.org](http://ruby-doc.org/).

### Part B — Word Count:

Define a function `count` in module `Words` that, given an input string,
return a hash whose keys are words in the string and whose values are
the number of times each word appears:

```ruby
Words.count("To be or not to be") # => {"to"=>2, "be"=>2, "or"=>1, "not"=>1}
```

Your solution shouldn't use for-loops, but iterators like `each` are
permitted. As before, nonwords and case should be ignored. A word is
defined as a string of characters between word boundaries.

What may help: `String#gsub`, `String#split`, `String#downcase`,
`Enumerable#group_by`. Check it out on [ruby-doc.org](http://ruby-doc.org/).


### Part C — Anagrams: (DIFFICULT)

An anagram group is a group of words such that any one can be converted
into any other just by rearranging the letters. For example, "rats",
"tars" and "star" are an anagram group.

Given a space separated list of words in a single string, write a method
that groups them into anagram groups and returns the array of groups.
Case doesn't matter in classifying string as anagrams (but case should
be preserved in the output), and the order of the anagrams in the groups
doesn't matter.

```ruby
anagrams("rats What star thaw Tars") # => should return [["rats", "star", "Tars"], ["What", "Thaw"]]
                                     #    arrays or item in arrays may come in any order
```

## 2. Rock Paper Scissors (NO TESTS AND FILES YET)

In a game of rock-paper-scissors, each player chooses to play Rock (R),
Paper (P), or Scissors (S). The rules are: Rock breaks Scissors,
Scissors cuts Paper, but Paper covers Rock.

In a round of rock-paper-scissors, each player's name and strategy is
encoded as an array of two elements

```ruby
[ ["Joker", "P"], ["Batman", "S"] ] # Batman would win since S > P
```

### Part A. Game Winner:

Create a `RockPaperScissors` class with a class method winner that takes
two 2-element arrays like those above, and returns the one representing
the winner:

```ruby
RockPaperScissors.winner(['Joker','P'], ['Batman','S'])  # => ['Batman','S']
```

If either player's strategy is something other than "R", "P" or "S"
(case-SENSITIVE), the method should raise a
`RockPaperScissors::NoSuchStrategyError` exception, and provide the
message: "Strategy must be one of R,P,S".

If both players use the same strategy, the first player is the winner.


### Part B. Tournament (DIFFICULT):

A rock-paper-scissors tournament is encoded as an array of games - that
is, each element can be considered its own tournament.

```ruby
[
  [
    [ ["Ivy", "P"], ["Copperhead", "S"] ],
    [ ["Batman", "R"],  ["Joker", "S"] ],
  ],
  [
    [ ["Catwoman", "S"], ["Two-Face", "P"] ],
    [ ["Penguin", "R"], ["Riddler", "P"] ]
  ]
]
```

In the tournament above Ivy will always play P and Dave will always play S. This tournament plays out as follows:

Under this scenario, Copperhead would beat Ivy (S>P) and Batman would
beat Joker (R>S), so Copperhead and Batman would play (Batman wins since
R>S); similarly, Catwoman would beat Two-Face, Riddler would beat
Penguin, and Catwoman and Riddler would play (Catwoman wins since S>P);
and finally Batman would beat Catwoman since R>S. That is, pairwise play
continues until there is only a single winner.

Write a method `RockPaperScissors.tournament_winner' that takes a
tournament encoded as an array and returns the winner (for the above
example, it should return `['Batman', 'R']`). You can assume that the
array is well formed (that is, there are 2^n players, and each one
participates in exactly one match per round).

HINT: Formulate the problem as a recursive one whose base case you
solved in part 1.

## 3. Metaprogramming (NO TESTS AND FILES YET)

We saw how attr_accessor uses metaprogramming to create getters and
setters for object attributes on the fly.

Define a method attr_accessor_with_history that provides the same
functionality as attr_accessor but also tracks every value the attribute
has ever had:

```ruby
class Foo
  attr_accessor_with_history :bar
end

f = Foo.new
f.bar = 3          # => 3
f.bar = :wowzo     # => :wowzo
f.bar = 'boo!'     # => 'boo!'
f.bar_history      # => [nil, 3, :wowzo]
# (Calling bar_history before bar's setter is ever called should return nil.)
```

History of instance variables should be maintained separately for each
object instance. that is:

```ruby
f = Foo.new
f.bar = 1 ; f.bar = 2
g = Foo.new
g.bar = 3 ; g.bar = 4
g.bar_history
```

then the last line should just return [nil,3], rather than [nil,1,3].

If you're interested in how the template works, the first thing to
notice is that if we define `attr_accessor_with_history` in class
`Class`, we can use it as in the snippet above. This is because a Ruby
class like `Foo `or `String` is actually just an object of class
`Class`. (If that makes your brain hurt, just don't worry about it for
now. It'll come.)

The second thing to notice is that Ruby provides a method `class_eval`
that takes a string and evaluates it in the context of the current
class, that is, the class from which you're calling
`attr_accessor_with_history`. This string will need to contain a method
definition that implements a setter-with-history for the desired
attribute attr_name.

HINTS:

* Don't forget that the very first time the attribute receives a value,
  its history array will have to be initialized.
* If `foo_history` is referenced before foo has ever been assigned, the
  correct answer is `[]`, but after the first assignment to foo, the
  correct value for `foo_history` would be `[nil]`.
* Don't forget that instance variables are referred to as `@bar` within
  getters and setters.
  Although the existing attr_accessor can handle multiple arguments (e.g.
  `attr_accessor :foo, :bar`), your version just needs to handle a single
  argument.  Your implementation should be general enough to work in the
  context of any class and for attributes of any (legal) variable name.

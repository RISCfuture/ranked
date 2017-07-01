# A stack is a collection of {Card cards} that a user can rank. Each card
# contains the name of something to be ranked. For example, a stack could group
# together a bunch of cards with the names of baseball teams on them, and a
# user could then rank those teams.
#
# Stacks rank cards using the Elo algorithm. The Elo algorithm requires that the
# cards be displayed in pairs, and the user choose the better of each pair. Once
# that is done, the algorithm is applied to each of these "matches" to create a
# score, and thus a ranking, for each card. See the {#rank} method for more.
#
# When a stack is first created, the cards are shuffled and saved in a random
# order. The cards are then paired together in every possible combination, and
# the order of those pairs is also randomized. This random order is saved along
# with the stack (in the `pairs_order` property). People ranking the stack will
# see pairs of cards in this random order, but never in any other order. This
# allows the URL to contain the encoded match results in a known order,
# eliminating the need to store match results in the database.
#
# A pseudo-property called {#card_names} is available for use with the
# front-end; this property allows users to create a stack and its cards
# efficiently with one form.
#
# To keep URLs small, stacks are referenced by their base-36 ID, rather than
# their base-10 ID.
#
# Associations
# ------------
#
# |         |                                 |
# |:--------|:--------------------------------|
# | `cards` | The {Card cards} in this stack. |
#
# Properties
# ----------
#
# |               |                                                                                                                                                    |
# |:--------------|:---------------------------------------------------------------------------------------------------------------------------------------------------|
# | `name`        | The name of the stack, such as "Baseball teams".                                                                                                   |
# | `pairs_order` | An automatically-generated list of all possible two-card pairs (as Card IDs), in a random but persistent order (automatically serialized to JSON). |

class Stack < ApplicationRecord
  # A newline-delimited list of card names. Use this field with front-end forms
  # to allow users to quickly generate cards by just entering them one per line
  # in a text field. `card_names` is only used on create.
  #
  # @return [String] A newline-delimited list of card names to be created as
  #   this stack is also created.
  attr_accessor :card_names

  serialize :pairs_order, JSON

  has_many :cards, dependent: :delete_all, inverse_of: :stack

  validates :name,
            presence: true,
            length:   {maximum: 126}
  validates_associated :cards
  validate :at_least_two_cards

  before_validation :make_cards, on: :create
  before_validation :order_pairs, on: :create

  # @private
  def to_param
    id.to_s(36)
  end

  # Locates a stack by its base-36 ID.
  #
  # @param [String] hash A base-36 Stack ID.
  # @return [Stack] The Stack with that ID.
  # @raise [ActiveRecord::RecordNotFound] If no Stack exists with that ID.

  def self.find_by_hash!(hash)
    id = Integer(hash, 36)
    find(id)
  end

  K = 32.0
  private_constant :K

  # Uses the Elo algorithm to rank cards given an array of match results.
  # `matches` is an array of the same size as `pairs_order`. For each element
  # in `pairs_order`, there is an element in `matches` that is one of the
  # following:
  #
  # * If the first card of the pair was chosen: `:first`
  # * If the second card of the pair was chosen: `:second`
  # * If both cards were equal: `:both`
  # * If the match was not played: `nil`
  #
  # This method will return an ordered array of (card, score) pairs, with the
  # highest-scoring card first.
  #
  # This implementation of the Elo algorithm uses a constant _K_-value of 32.
  #
  # @param [Array<:first, :second, :both, nil>] matches The results of each of
  #   the matches in `pairs_order`.
  # @return [Array<(Card, Integer)>] An ordered array of cards and their scores,
  #   winner first.

  def rank(matches)
    ratings = Array.new(cards.count, 0)
    pairs_order.zip(matches).each do |(index1, index2), winner|
      next unless winner

      rating1             = ratings[index1]
      rating2             = ratings[index2]
      transformed_rating1 = 10**(rating1/400.0)
      transformed_rating2 = 10**(rating2/400.0)
      expected_score1     = transformed_rating1/(transformed_rating1+transformed_rating2)
      expected_score2     = transformed_rating2/(transformed_rating1+transformed_rating2)
      score1              = case winner
                              when :first then 1
                              when :second then 0
                              when :both then 0.5
                            end
      score2              = case winner
                              when :first then 0
                              when :second then 1
                              when :both then 0.5
                            end
      ratings[index1]     += K*(score1 - expected_score1)
      ratings[index2]     += K*(score2 - expected_score2)
    end

    return cards.order(id: :asc).zip(ratings).sort_by(&:last).reverse
  end

  private

  def make_cards
    return unless card_names

    card_names.split("\n").shuffle.each do |line|
      next if line.blank?
      cards.build(name: line.strip)
    end
  end

  def order_pairs
    pairs = Array.new
    0.upto(cards.size - 2) do |i|
      (i+1).upto(cards.size - 1) do |j|
        pairs << [i, j]
      end
    end
    pairs.shuffle!
    self.pairs_order = pairs
  end

  def at_least_two_cards
    if cards.size < 2
      errors.add :cards, :too_few
    end
  end
end

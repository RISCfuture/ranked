# A card is an item that can be ranked, as part of a {Stack stack}. If the stack
# is "baseball teams", one of its cards might be "Oakland A's".
#
# Associations
# ------------
#
# |         |                                         |
# |:--------|:----------------------------------------|
# | `stack` | The {Stack stack} this card belongs to. |
#
# Properties
# ----------
#
# |        |                                    |
# |:-------|:-----------------------------------|
# | `name` | The text to display for this card. |

class Card < ApplicationRecord
  belongs_to :stack, inverse_of: :cards

  validates :name,
            presence: true,
            length: {maximum: 126},
            uniqueness: {scope: :stack_id}
end

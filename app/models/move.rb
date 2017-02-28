class Move < ApplicationRecord
  belongs_to :board
  enum action: [:reveal, :flag]
end

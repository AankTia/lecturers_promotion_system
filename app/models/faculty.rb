class Faculty < ActiveRecord::Base
  attr_readonly :code

  validates :code, presence: true,
                   length:     { in: 1..255 },
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
end

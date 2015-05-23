class RankOfLecturer < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  attr_readonly :code

  after_initialize :set_default_values, if: :new_record?

  def set_default_values
    self.code = SecureRandom.uuid
  end

  validates :code, presence: true,
                   length:     { in: 1..255 },
                   uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :symbol, presence: true,
                             uniqueness: { case_sensitive: false }



  def basic_salary_format
    number_to_currency(basic_salary, unit: "Rp. ", separator: ",", delimiter: ".")
  end
end

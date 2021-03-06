class Cat < ActiveRecord::Base
  COLORS = %w(Black Brown White Spotted)

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS, message: "No other colors allowed!!!" }
  validates :sex, inclusion:{ in: %w(M F), message: "Sorry, no gender binaries."}
  has_many :cat_rental_requests, :dependent => :destroy
  belongs_to :owner

  def age
    require 'date'
    d = Date.new(2016, 8, 2)
    current_year = d.year
    cat_year = self.birth_date.year
    (current_year - cat_year)
  end

end

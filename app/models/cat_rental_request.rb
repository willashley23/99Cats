class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "Invalid status" }
  validate :overlapping_requests
  belongs_to :cat

# Add a validation that no two APPROVED cat requests for the same cat can overlap in time.

  def overlapping_requests
    start = self.start_date
    ending = self.end_date
    self.cat.cat_rental_requests.where("(start_date BETWEEN(:start AND :ending) OR end_date BETWEEN(:start AND :ending)) OR (start_date < :start AND end_date > :ending)",
      start: start, ending: ending)
    #   errors[:overlapping_dates] << "Overlapping dates!"
    #   puts self.errors.full_messages
    # end
  end

  def overlapping_approved_requests

  end


end

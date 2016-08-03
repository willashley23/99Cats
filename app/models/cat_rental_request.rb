class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "Invalid status" }
  validate :overlapping_approved_requests
  belongs_to :cat

# Add a validation that no two APPROVED cat requests for the same cat can overlap in time.
  def overlapping_requests
    CatRentalRequest
     .where.not(id: self.id)
     .where(cat_id: cat_id)
     .where(<<-SQL, start_date: start_date, end_date: end_date)
        NOT( (start_date > :end_date) OR (end_date < :start_date) )
     SQL
  end

  def overlapping_approved_requests
    unless overlapping_requests.where("status = 'APPROVED'").empty?
      errors[:bad_request] << "Invalid date range, dates overlap"
    end
  end


end

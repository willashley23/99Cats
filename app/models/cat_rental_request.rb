class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w(PENDING APPROVED DENIED), message: "Invalid status" }
  validate :overlapping_approved_requests
  belongs_to :cat

# Add a validation that no two APPROVED cat requests for the same cat can overlap in time.

  def overlapping_requests
    # start = self.start_date
    # ending = self.end_date
    # first_failure = self.cat.cat_rental_requests.where((self.start_date): start_date..end_date).to_a
    # second_failure = self.cat.cat_rental_requests.where((self.end_date): start_date..end_date).to_a
    # # third_failure = self.cat.cat_rental_requests.where('start_date: < start AND end_date: > ending').to_a
    # (first_failure + second_failure ).empty?
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

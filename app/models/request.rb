class Request
  include DataMapper::Resource

  property :id, Serial
  property :accepted, Boolean
  property :rejected, Boolean

  belongs_to :user
  belongs_to :playlist

  def initialize
    self.accepted = false
    self.rejected = false
  end

  def pending?
    !(self.accepted || self.rejected)
  end

  def status
    return "Pending" if pending?
    return "Accepted" if self.accepted
    return "Rejected" if self.rejected
  end
end

class PhotographerPlan < ActiveRecord::Base
  scope :active, -> { where(status: Status::ACTIVE).first }
  belongs_to :photographer
  belongs_to :plan

  class Status
    PENDING = '2'
    ACTIVE  = '1'
    EXPIRED = '0'
    TEXT    =   {
      PENDING   =>  'Pending',
      ACTIVE    =>  'Active',
      EXPIRED   =>  'Expired'
    }
  end

  def self.pending_plan?
    where(status: Status::PENDING).present?  
  end

  def self.active_plan?
    where(status: Status::ACTIVE).present?  
  end

  def active?
    status == Status::ACTIVE
  end

  def pending?
    status == Status::PENDING
  end
end


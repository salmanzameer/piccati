class PhotographerPlan < ActiveRecord::Base
  belongs_to :photographer
  belongs_to :plan

  class Status
    PENDING = 2
    ACTIVE  = 1
    EXPIRED = 0
    TEXT    =   {
      PENDING   =>  'Pending',
      ACTIVE    =>  'Active',
      EXPIRED   =>  'Expired'
    }
  end
end
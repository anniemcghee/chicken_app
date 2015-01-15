class ChickensTags < ActiveRecord::Base
  belongs_to :chicken
  belongs_to :tag
end

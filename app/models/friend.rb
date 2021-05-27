class Friend < ApplicationRecord
   validates :first_name , presence: true
   validates :last_name , presence: true
   validates :phone , presence: true
   belongs_to :user
end

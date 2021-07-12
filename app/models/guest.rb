class Guest < ApplicationRecord
    def self.search(search)
        if search
            # @visitor = Visitor.where(["ph LIKE ?","%"+search+"%"])
            Guest.find_by(phone:"#{search}")
        else
             nil
            # @visitor= nil
        end
    end

    has_many :mettings
    accepts_nested_attributes_for :mettings 
end

require 'securerandom'

class Deck < ApplicationRecord

    has_and_belongs_to_many :cards

    before_save :generate_uuid

    def generate_uuid
        self.uuid = SecureRandom.uuid if self.uuid.nil? || self.uuid.empty?
    end

end

class Contact < ApplicationRecord
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    VALID_PHONE_REGEX = /\A[(][+]\d{2}+[)]\s\d{3}[ -]\d{3}[ -]\d{2}[ -]\d{2}/
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
    validates :phone, presence: true, uniqueness: true, format: { with: VALID_PHONE_REGEX }
    validates :birthday, presence: true
    validates :credit_card, presence: true
    validates :franchise, presence: true
    validates :address, presence: true
    encrypts :credit_card
    belongs_to :user

    def self.assign_from_row(row, csv_headers)
        contact = Contact.where(email: row[:email]).first_or_initialize        
        contact_fields = row.to_hash.slice(*csv_headers)
        unless CreditCardValidator::Validator.valid?(contact_fields["credit_card"])
            contact_fields["franchise"] = "unknown"
            contact.errors.add(:credit_card, "Invalid credit card number")
        else
            contact_fields["franchise"] = CreditCardValidator::Validator.card_type(contact_fields["credit_card"])
        end
        byebug
        contact.assign_attributes contact_fields
        byebug
        contact
    end
end
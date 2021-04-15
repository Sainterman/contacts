class Contact::Import
    include ActiveModel::Model
    attr_accessor :current_user, :file, :csv_headers, :imported_count, :field_1, :field_2, :field_3, :field_4, :field_5, :field_6

    def set_csv_headers
        @csv_headers = [@field_1, @field_2, @field_3, @field_4, @field_5, @field_6]
    end

    def process!
        @imported_count = 0
        CSV.foreach(file.path, headers: csv_headers) do |row|
            contact = Contact.assign_from_row(row, csv_headers)
            contact.user_id = @current_user.id
            byebug
            if contact.save
                @imported_count += 1
                byebug
            else
                errors.add(:base, "Line #{$.} - #{contact.errors.full_messages.join(",")}")
                byebug
            end
        end
    end

    def save
        process!
        errors.none?
    end
end
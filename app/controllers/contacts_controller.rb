class ContactsController < ApplicationController
    def new
        @contact = Contact.new
        @import = Contact::Import.new
    end

    def index
        @contacts = Contact.all
    end

    def import
        @import = Contact::Import.new contact_import_params
        @import.set_csv_headers
        @import.current_user = current_user
        if @import.csv_headers.uniq.length == @import.csv_headers.length
            if @import.save
                redirect_to contacts_path, notice: "Imported #{@import.imported_count} users"
            else
                @contact = Contact.new
                flash[:notice] = "there were errors with your CSV file"
                render :new
            end
        else
            @contact = Contact.new
            flash[:alert] = "Please avoid repeating fields"
            render :new
        end
    end 

    private 
    
    def contact_import_params
        params.permit(:file,:field_1,:field_2,:field_3,:field_4,:field_5,:field_6)
    end
end
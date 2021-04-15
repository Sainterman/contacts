class ChangeBirthdayType < ActiveRecord::Migration[6.1]
  def change
    change_column :contacts, :birthday, 'date USING birthday::date'
  end
end

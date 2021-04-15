class AddCreditCardCiphertextToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :credit_card_ciphertext, :text
  end
end

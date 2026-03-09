class ChangeContactsAddPolymorphicType < ActiveRecord::Migration[8.1]
  def change
    # Remove o campo contact_id da coluna
    remove_column :contacts, :contact_id, :bigint

    # Adiciona os campos contactable_type e contactable_id para a associação polimórfica
    add_reference :contacts, :contactable, polymorphic: true, index: true

    add_index :contacts, [:user_id, :contactable_id, :contactable_type], unique: true, name: 'index_contacts_on_user_and_contactable'
  end
end

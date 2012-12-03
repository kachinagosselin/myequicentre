class AddContactDetailsToUsers < ActiveRecord::Migration

        def change
            add_column :users, :phone_number, :int
            add_column :users, :website, :string
            add_column :users, :preferred_contact, :string
        end
        
        def down
            remove_column :users, :phone_number
            remove_column :users, :website
            remove_column :users, :preferred_contact
        end
end
class AddReceiveNewsletterToUsers < ActiveRecord::Migration
        def change
            add_column :users, :join_mailing_list, :boolean
        end
        
        def down
            remove_column :users, :join_mailing_list
        end
end

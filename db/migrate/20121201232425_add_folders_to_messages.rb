class AddFoldersToMessages < ActiveRecord::Migration

        def change
            add_column :messages, :folder, :string
        end
        
        def down
            remove_column :messages, :folder
        end
end

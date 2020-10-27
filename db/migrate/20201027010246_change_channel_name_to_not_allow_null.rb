class ChangeChannelNameToNotAllowNull < ActiveRecord::Migration[6.0]
  change_column :channels, :name, :string, null: false
end

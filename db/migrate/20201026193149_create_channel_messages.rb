class CreateChannelMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :channel_messages do |t|
      t.references :channel, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end

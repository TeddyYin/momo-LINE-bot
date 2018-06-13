class AddChannelNameToChannelModel < ActiveRecord::Migration[5.0]
  def change
    add_column :channels, :channel_name, :string
  end
end

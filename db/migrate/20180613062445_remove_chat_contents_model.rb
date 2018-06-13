class RemoveChatContentsModel < ActiveRecord::Migration[5.0]
  def change
    drop_table :chat_contents
  end
end

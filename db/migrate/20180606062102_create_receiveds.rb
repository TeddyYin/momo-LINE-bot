class CreateReceiveds < ActiveRecord::Migration[5.0]
  def change
    create_table :receiveds do |t|
      t.string :channel_id
      t.string :text

      t.timestamps
    end
  end
end

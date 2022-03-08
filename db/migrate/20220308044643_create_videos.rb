class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.string :title, null:false
      t.string :category, null:false
      t.string :url, null:false
      t.string :thumbnail, null:false
      t.string :channelName, null:false
      t.text :description

      t.timestamps
    end
  end
end

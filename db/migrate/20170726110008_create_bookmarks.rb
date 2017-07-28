class CreateBookmarks < ActiveRecord::Migration[5.1]
  def change
    create_table :bookmarks do |t|
    t.belongs_to :user, index: true
    t.belongs_to :post, index: true
    t.timestamps
    end
  end
end

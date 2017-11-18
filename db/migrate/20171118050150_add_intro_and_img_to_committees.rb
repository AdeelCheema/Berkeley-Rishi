class AddIntroAndImgToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :intro, :text
    add_column :committees, :intro_img, :string
  end
end

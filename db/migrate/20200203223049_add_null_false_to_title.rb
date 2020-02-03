class AddNullFalseToTitle < ActiveRecord::Migration[5.2]
  def change
    change_column(:polls, :title, :string, null: false)
  end
end

class AddUniqueContraintToPolls < ActiveRecord::Migration[5.2]
  def change
    add_index :polls, [:author_id, :title], unique: true
  end
end

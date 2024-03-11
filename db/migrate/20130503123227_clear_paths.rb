class ClearPaths < ActiveRecord::Migration
  def change
    Path.delete_all
  end
end

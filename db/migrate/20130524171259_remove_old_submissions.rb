class RemoveOldSubmissions < ActiveRecord::Migration
  def change
    Submission.delete_all
  end
end

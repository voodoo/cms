class AddTrackedSessionToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :tracked_session, :text
  end
end

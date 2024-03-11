class AddTranscriptionToIncomingCalls < ActiveRecord::Migration
  def change
    add_column :incoming_calls, :transcription, :string, :limit => 1024
  end
end

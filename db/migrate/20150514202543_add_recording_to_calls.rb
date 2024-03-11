class AddRecordingToCalls < ActiveRecord::Migration
  def change
  	add_column 		:incoming_calls, 		:recorded_message_url, 			:string
  	add_column 		:incoming_calls, 		:recorded_message_duration, :string
  	add_column 		:incoming_calls, 		:recording_url, 						:string
  	rename_column :incoming_calls, 		:transcription, 						:recorded_message_transcript
  	add_column 		:comments, 		      :recording_url, 						:string
  	add_column 		:incoming_calls,    :user_id, 						      :integer
  	rename_column :contacts, 					:severity, 									:priority
  end
end

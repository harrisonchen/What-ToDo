class UpdateExistingTaskStatusDefaults < ActiveRecord::Migration
  	def change
  		Task.update_all( { status: false}, { status: nil} )
  	end
end

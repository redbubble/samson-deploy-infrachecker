class AddCheckInfraspecBeforeAutodeployToProject < ActiveRecord::Migration
  def change
    add_column :projects, :check_infraspec_before_autodeploy, :boolean, default: false
  end
end

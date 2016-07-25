class AddBuildkiteApiTokenToProject < ActiveRecord::Migration
  def change
    add_column :projects, :buildkite_api_token, :string
  end
end

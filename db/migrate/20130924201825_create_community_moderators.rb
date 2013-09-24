class CreateCommunityModerators < ActiveRecord::Migration
  def change
    create_table :community_moderators do |t|
      t.references :community, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end

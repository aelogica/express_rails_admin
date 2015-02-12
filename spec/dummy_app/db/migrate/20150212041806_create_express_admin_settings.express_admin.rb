# This migration comes from express_admin (originally 20141031004627)
class CreateExpressAdminSettings < ActiveRecord::Migration
  def change
    create_table :express_admin_settings do |t|
      t.string :setting
      t.string :value
      t.string :type
    end
  end
end

class AddAppNamespaceToAuthenticationMethod < ActiveRecord::Migration
  def change
    add_column :spree_authentication_methods, :app_namespace, :string
  end
end

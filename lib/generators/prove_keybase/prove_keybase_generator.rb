class ProveKeybaseGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Migration
  source_root File.expand_path('templates', __dir__)

  def install
    copy_file "initializer.rb", "config/initializers/prove_keybase.rb"
    migration_template "migration.rb", "db/migrate/create_keybase_proofs.rb"
    copy_file "base_controller.rb", "app/controllers/keybase_base_controller.rb"
    copy_file "new_proof.html.erb", "app/views/prove_keybase/proofs/new.html.erb"
  end

  def self.next_migration_number(dir)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end
end

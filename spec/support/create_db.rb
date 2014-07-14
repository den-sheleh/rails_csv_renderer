require 'active_record'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.define(version: 1) do
  create_table :people, force: true do |t|
    t.string :first_name
    t.string :last_name
  end

  create_table :cats, force: true do |t|
    t.string :name
    t.integer :person_id
  end
end

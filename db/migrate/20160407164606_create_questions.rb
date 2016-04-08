# this file just defines how the table should look like and doesnt create the table. to create a table run: bin/rake db:migrate

# bin/rake db:rollback - rolls back (it is destructive)

class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      # No need to add ID as this is auto generated with autoincrement.
      t.string :title
      t.text :body
      #time stamp will add two extra fields: created_at and updated_at
      #they will be of type datetime
      #they will be automatically seet by ActiveRecord
      t.timestamps null: false
    end
  end
end

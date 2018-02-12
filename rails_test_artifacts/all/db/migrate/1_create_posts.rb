if Rails::VERSION::MAJOR >= 5
  CreatePostsParentClass = ActiveRecord::Migration["#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}"]
else
  CreatePostsParentClass = ActiveRecord::Migration
end

class CreatePosts < CreatePostsParentClass
  def self.up
    create_table :posts do |t|
      t.column :title, :string
      t.column :body, :text
    end
  end
  
  def self.down
  end
end

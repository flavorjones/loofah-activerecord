require File.join(File.dirname(__FILE__), "../test_helper")
begin
  require "test/unit"
rescue NameError
  require "minitest"
end

if defined?(Minitest::Test)
  LoofahTestBaseClass = Minitest::Test
else
  LoofahTestBaseClass = Test::Unit::TestCase
end

class PostsTest < LoofahTestBaseClass
  def test_loofah_scrubbing
    post = Post.new :title => "<script>yo dawg</script>", :body => "<script>omgwtfbbq</script>"
    post.valid?
    assert_equal "yo dawg", post.title
    assert_equal "omgwtfbbq", post.body
  end

  def test_xss_foliation
    assert Post.xss_foliated?
  end
end

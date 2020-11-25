require "helper"

class TestActiveRecord < Loofah::ActiveRecord::TestCase

  HTML_STRING = "<div>omgwtfbbq</div>"
  PLAIN_TEXT  = "vanilla text"

  context "with a Post model" do
    with_model :Post do
      table do |t|
        t.string :plain_text
        t.string :html_string
      end
    end

    context "scrubbing a single field as a fragment" do
      context "using a symbol to indicate the attribute" do
        before do
          Post.html_fragment :html_string, :scrub => :prune
          assert ! Post.xss_foliated?
          @post = Post.new :html_string => HTML_STRING, :plain_text => PLAIN_TEXT
        end

        it "scrub the specified field" do
          mock(Loofah).scrub_fragment(HTML_STRING, :prune).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).never
          @post.valid?
        end

        it "only call scrub_fragment once" do
          mock(Loofah).scrub_fragment(anything, anything).once
          @post.valid?
        end

        it "generate strings" do
          @post.valid?
          assert_equal String,      @post.html_string.class
          assert_equal HTML_STRING, @post.html_string
        end
      end

      context "using a string to indicate the attribute" do
        before do
          Post.html_fragment 'html_string', :scrub => :prune
          assert ! Post.xss_foliated?
          @post = Post.new :html_string => HTML_STRING, :plain_text => PLAIN_TEXT
        end

        it "scrub the specified field" do
          mock(Loofah).scrub_fragment(HTML_STRING, :prune).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).never
          @post.valid?
        end
      end
    end

    context "scrubbing a single field as a document" do
      context "using a symbol to indicate the attribute" do
        before do
          Post.html_document :html_string, :scrub => :strip
          @post = Post.new :html_string => HTML_STRING, :plain_text => PLAIN_TEXT
        end

        it "scrub the specified field, but not other fields" do
          mock(Loofah).scrub_document(HTML_STRING, :strip).once
          mock(Loofah).scrub_document(PLAIN_TEXT,  :strip).never
          @post.valid?
        end

        it "only call scrub_document once" do
          mock(Loofah).scrub_document(anything, anything).once
          @post.valid?
        end

        it "generate strings" do
          @post.valid?
          assert_equal String, @post.html_string.class
        end
      end

      context "using a string to indicate the attribute" do
        before do
          Post.html_document 'html_string', :scrub => :strip
          @post = Post.new :html_string => HTML_STRING, :plain_text => PLAIN_TEXT
        end

        it "scrubs the specified field, but not other fields" do
          mock(Loofah).scrub_document(HTML_STRING, :strip).once
          mock(Loofah).scrub_document(PLAIN_TEXT,  :strip).never
          @post.valid?
        end
      end
    end

    context "not passing any options" do
      it "raises ArgumentError" do
        assert_raises(ArgumentError) {
          Post.html_fragment :foo
        }
      end
    end

    context "not passing :scrub option" do
      it "raises ArgumentError" do
        assert_raises(ArgumentError) {
          Post.html_fragment :foo, :bar => :quux
        }
      end
    end

    context "passing a :scrub option" do
      it "does not raise ArgumentError" do
        Post.html_fragment :foo, :scrub => :quux
      end
    end

    context "passing a Scrubber" do
      before do
        @called = false
        @scrubber = Loofah::Scrubber.new do |node|
          @called = true
        end
      end

      it "does not raise ArgumentError" do
        Post.html_fragment :html_string, :scrub => @scrubber
      end

      it "scrubs properly" do
        Post.html_fragment :html_string, :scrub => @scrubber
        post = Post.new :html_string => HTML_STRING, :plain_text => PLAIN_TEXT
        post.valid?
        assert @called
      end
    end
  end
end

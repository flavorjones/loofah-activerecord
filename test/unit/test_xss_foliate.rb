require "helper"

class TestXssFoliate < Loofah::ActiveRecord::TestCase

  HTML_STRING = "<div>omgwtfbbq</div>"
  PLAIN_TEXT = "vanilla text"
  INTEGER_VALUE = "1234"
  WHITESPACEY = " <br> "

  def new_post(overrides={})
    Post.new({:html_string => HTML_STRING, :plain_text => PLAIN_TEXT, :not_a_string => INTEGER_VALUE}.merge(overrides))
  end

  context "with a Post model" do
    before do
      ActsAsFu.build_model(:posts) do
        string :plain_text
        string :html_string
        integer :not_a_string
      end
    end

    context "#xss_foliated?" do
      context "when xss_foliate has not been called" do
        it "return false" do
          assert ! Post.xss_foliated?
        end
      end

      context "when xss_foliate has been called with no options" do
        before do
          Post.xss_foliate
        end

        it "return true" do
          assert Post.xss_foliated?
        end
      end

      context "when xss_foliate has been called with options" do
        before do
          Post.xss_foliate :prune => :plain_text
        end

        it "return true" do
          assert Post.xss_foliated?
        end
      end
    end

    context "#xss_foliate" do
      context "when passed invalid option" do
        it "raise ArgumentError" do
          assert_raises(ArgumentError) { Post.xss_foliate :quux => [:foo] }
        end
      end

      context "when passed a symbol" do
        it "calls the right scrubber" do
          Post.xss_foliate :prune => :plain_text
          mock(Loofah).scrub_fragment(HTML_STRING, :strip).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).once
          new_post.valid?
        end
      end

      context "when passed an array of symbols" do
        it "calls the right scrubbers" do
          Post.xss_foliate :prune => [:plain_text, :html_string]
          mock(Loofah).scrub_fragment(HTML_STRING, :prune).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).once
          new_post.valid?
        end
      end

      context "when passed a string" do
        it "calls the right scrubber" do
          Post.xss_foliate :prune => 'plain_text'
          mock(Loofah).scrub_fragment(HTML_STRING, :strip).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).once
          new_post.valid?
        end
      end

      context "when passed an array of strings" do
        it "calls the right scrubbers" do
          Post.xss_foliate :prune => ['plain_text', 'html_string']
          mock(Loofah).scrub_fragment(HTML_STRING, :prune).once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,  :prune).once
          new_post.valid?
        end
      end
    end

    context "declaring scrubbed fields" do
      context "on all fields" do
        before do
          Post.xss_foliate
        end

        it "scrub all fields" do
          mock_doc = Object.new
          mock(Loofah).scrub_fragment(HTML_STRING,   :strip).once.returns(mock_doc)
          mock(Loofah).scrub_fragment(PLAIN_TEXT,    :strip).once.returns(mock_doc)
          mock(Loofah).scrub_fragment(INTEGER_VALUE, :strip).never
          mock(mock_doc).text.times(2)
          assert new_post.valid?
        end
      end

      context "omitting one field" do
        before do
          Post.xss_foliate :except => [:plain_text]
        end

        it "not scrub omitted field" do
          mock_doc = Object.new
          mock(Loofah).scrub_fragment(HTML_STRING,   :strip).once.returns(mock_doc)
          mock(Loofah).scrub_fragment(PLAIN_TEXT,    :strip).never
          mock(Loofah).scrub_fragment(INTEGER_VALUE, :strip).never
          mock(mock_doc).text.once
          new_post.valid?
        end
      end

      Loofah::Scrubbers.scrubber_symbols.each do |method|
        context "declaring one field to be scrubbed with #{method}" do
          before do
            Post.xss_foliate method => [:plain_text]
          end

          it "scrub that field appropriately" do
            mock_doc = Object.new
            mock(Loofah).scrub_fragment(HTML_STRING,   :strip).once
            mock(Loofah).scrub_fragment(PLAIN_TEXT,    method).once.returns(mock_doc)
            mock(Loofah).scrub_fragment(INTEGER_VALUE, :strip).never
            mock(mock_doc).to_s
            new_post.valid?
          end
        end
      end

      context "declaring one field to be scrubbed with html5lib_sanitize" do
        before do
          Post.xss_foliate :html5lib_sanitize => [:plain_text]
        end

        it "not that field appropriately" do
          mock(Loofah).scrub_fragment(HTML_STRING,   :strip) .once
          mock(Loofah).scrub_fragment(PLAIN_TEXT,    :escape).once
          mock(Loofah).scrub_fragment(INTEGER_VALUE, :strip) .never
          new_post.valid?
        end
      end
    end

    context "invalid model data" do
      before do
        Post.validates_presence_of :html_string
        Post.xss_foliate
      end

      it "not be valid after sanitizing" do
        mock(Loofah).scrub_fragment(WHITESPACEY, :strip).once
        mock(Loofah).scrub_fragment(PLAIN_TEXT,  :strip).once
        assert ! new_post(:html_string => WHITESPACEY).valid?
      end
    end

    context "given an XSS attempt" do
      before do
        Post.xss_foliate :strip => :html_string
      end

      it "escape html entities" do
        hackattack = "<div>&lt;script&gt;alert('evil')&lt;/script&gt;</div>"
        post = new_post :html_string => hackattack, :plain_text => hackattack
        post.valid?
        assert_equal "<div>&lt;script&gt;alert('evil')&lt;/script&gt;</div>", post.html_string
        assert_equal "&lt;script&gt;alert('evil')&lt;/script&gt;", post.plain_text
      end
    end

    context "these tests should pass for libxml 2.7.5 and later" do
      before do
        Post.xss_foliate
      end

      it "not scrub double quotes into html entities" do
        answer = new_post(:plain_text => "\"something\"")
        answer.valid?
        assert_equal "\"something\"", answer.plain_text
      end

      it "not scrub ampersands into html entities" do
        answer = new_post(:plain_text => "& Something")
        answer.valid?
        assert_equal "& Something", answer.plain_text
      end

      it "not scrub \\r html entities" do
        answer = new_post(:plain_text => "Another \r Something")
        answer.valid?
        assert_equal "Another \r Something", answer.plain_text
      end

      it "not scrub \\n html entities" do
        answer = new_post(:plain_text => "Another \n Something")
        answer.valid?
        assert_equal "Another \n Something", answer.plain_text
      end
    end
  end
end


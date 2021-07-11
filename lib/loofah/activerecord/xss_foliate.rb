module Loofah
  #
  # A replacement for XssTerminate[http://github.com/look/xss_terminate/tree/master], XssFoliate
  # will strip all tags from your ActiveRecord models' string and text attributes.
  #
  # Please read the Loofah documentation for an explanation of the
  # different scrubbing methods, and
  # Loofah::XssFoliate::ClassMethods for more information on the
  # methods.
  #
  # If you'd like to scrub all fields in all your models (and perhaps *opt-out* in specific models):
  #
  #   # config/initializers/loofah.rb
  #   require 'loofah-activerecord'
  #   Loofah::XssFoliate.xss_foliate_all_models
  #
  #   # db/schema.rb
  #   create_table "posts" do |t|
  #     t.string  "title"
  #     t.text    "body"
  #     t.string  "author"
  #   end
  #
  #   # app/model/post.rb
  #   class Post < ActiveRecord::Base
  #     # by default, title, body and author will all be scrubbed down to their inner text
  #   end
  #
  # OR
  #
  #   # app/model/post.rb
  #   class Post < ActiveRecord::Base
  #     xss_foliate :except => :author  # opt-out of sanitizing author
  #   end
  #
  # OR
  #
  #     xss_foliate :strip => [:title, body]  # strip unsafe tags from both title and body
  #
  # OR
  #
  #     xss_foliate :except => :title         # scrub body and author but not title
  #
  # OR
  #
  #     # remove all tags from title, remove unsafe tags from body
  #     xss_foliate :sanitize => :title, :scrub => :body
  #
  # OR
  #
  #     # old xss_terminate code will work if you s/_terminate/_foliate/
  #     # was: xss_terminate :except => [:title], :sanitize => [:body]
  #     xss_foliate :except => [:title], :sanitize => [:body]
  #
  # OR
  #
  #     # when the final content is intended for non-html contexts,
  #     # such as plaintext email, you can turn off entity encoding
  #     # for all fields
  #     xss_foliate :encode_special_chars => false   # do *not* escape HTML entities in any field. NOTE THAT THE RESULT IS UNSAFE FOR RENDERING IN HTML CONTEXTS.
  #
  # OR
  #
  #     # or you can turn off entity encoding only for specific fields.
  #     xss_foliate :unencode_special_chars => [:title]  # will escape HTML entities in all fields except title. NOTE THAT `TITLE` IS UNSAFE FOR RENDERING IN HTML CONTEXTS.
  #
  #
  # Alternatively, if you would like to *opt-in* to the models and attributes that are sanitized:
  #
  #   # config/initializers/loofah.rb
  #   require 'loofah-activerecord'
  #   ## note omission of call to Loofah::XssFoliate.xss_foliate_all_models
  #
  #   # db/schema.rb
  #   create_table "posts" do |t|
  #     t.string  "title"
  #     t.text    "body"
  #     t.string  "author"
  #   end
  #
  #   # app/model/post.rb
  #   class Post < ActiveRecord::Base
  #     xss_foliate  # scrub title, body and author down to their inner text
  #   end
  #
  module XssFoliate
    #
    # A replacement for
    # XssTerminate[http://github.com/look/xss_terminate/tree/master],
    # XssFoliate will strip all tags from your ActiveRecord models'
    # string and text attributes.
    #
    # See Loofah::XssFoliate for more example usage.
    #
    module ClassMethods
      # :stopdoc:
      SYMBOL_OPTIONS = [:except, :html5lib_sanitize, :sanitize, :unencode_special_chars] + Loofah::Scrubbers.scrubber_symbols
      BOOLEAN_OPTIONS = {:encode_special_chars => true}
      ALIASED_SYMBOL_OPTIONS = {:html5lib_sanitize => :escape, :sanitize => :strip}
      REAL_SYMBOL_OPTIONS = SYMBOL_OPTIONS - ALIASED_SYMBOL_OPTIONS.keys
      VALID_OPTIONS = SYMBOL_OPTIONS + BOOLEAN_OPTIONS.keys + ALIASED_SYMBOL_OPTIONS.keys
      # :startdoc:

      def self.extended(base)
        # Rails 3.0 and later
        if base.respond_to?(:class_attribute)
          base.send(:class_attribute, :xss_foliate_options)
        end
      end

      #
      # Annotate your model with this method to specify which fields
      # you want scrubbed, and how you want them scrubbed. XssFoliate
      # assumes all character fields are HTML fragments (as opposed to
      # full documents, see the Loofah[http://loofah.rubyforge.org/]
      # documentation for a full explanation of the difference).
      #
      # Example call:
      #
      #  xss_foliate :except => :author, :strip => :body, :prune => [:title, :description]
      #
      # *Note* that the values in the options hash can be either an
      # array of attributes or a single attribute.
      #
      # Options:
      #
      #  :except => [fields] # don't scrub these fields
      #  :strip  => [fields] # strip unsafe tags from these fields
      #  :escape => [fields] # escape unsafe tags from these fields
      #  :prune  => [fields] # prune unsafe tags and subtrees from these fields
      #  :text   => [fields] # remove everything except the inner text from these fields
      #
      # XssTerminate compatibility options (note that the default
      # behavior in XssTerminate corresponds to :text)
      #
      #  :html5lib_sanitize => [fields] # same as :escape
      #  :sanitize          => [fields] # same as :strip
      #
      # The default is :text for all fields unless otherwise specified.
      #
      def xss_foliate(options = {})
        callback_already_declared = \
        if respond_to?(:class_attribute)
          # Rails 3.0 and later
          false
        elsif respond_to?(:before_validation_callback_chain)
          # Rails 2.1 and later
          before_validation_callback_chain.any? {|cb| cb.method == :xss_foliate_fields}
        else
          # Rails 2.0
          cbs = read_inheritable_attribute(:before_validation)
          (! cbs.nil?) && cbs.any? {|cb| cb == :xss_foliate_fields}
        end

        unless callback_already_declared
          before_validation        :xss_foliate_fields
          unless respond_to?(:class_attribute)
            # Rails 3.0 and later
            class_inheritable_reader :xss_foliate_options
          end
          include XssFoliate::InstanceMethods
        end

        options.keys.each do |option|
          raise ArgumentError, "unknown xss_foliate option #{option}" unless VALID_OPTIONS.include?(option)
        end

        REAL_SYMBOL_OPTIONS.each do |option|
          options[option] = Array(options[option]).collect { |val| val.to_sym }
        end

        ALIASED_SYMBOL_OPTIONS.each do |option, real|
          options[real] += Array(options.delete(option)).collect { |val| val.to_sym } if options[option]
        end

        BOOLEAN_OPTIONS.each do |option, default|
          case options[option]
          when FalseClass
          when TrueClass
          when NilClass
            options[option] = default
          else
            raise "option #{option} only accepts `true` or `false` values"
          end
        end

        if respond_to?(:class_attribute)
          # Rails 3.0 and later
          self.xss_foliate_options = options
        else
          write_inheritable_attribute(:xss_foliate_options, options)
        end
      end

      #
      # Class method to determine whether or not this model is applying
      # xss_foliation to its attributes. Could be useful in test suites.
      #
      def xss_foliated?
        options =
          if respond_to?(:class_attribute)
            # Rails 3.0 and later
            xss_foliate_options
          else
            read_inheritable_attribute(:xss_foliate_options)
          end
        ! (options.nil? || options.empty?)
      end
    end

    module InstanceMethods
      def xss_foliate_fields # :nodoc:
        # fix a bug with Rails internal AR::Base models that get loaded before
        # the plugin, like CGI::Sessions::ActiveRecordStore::Session
        return if xss_foliate_options.nil?

        self.class.columns.each do |column|
          next unless (column.type == :string || column.type == :text)

          field = column.name.to_sym
          value = self[field]

          next if !value.is_a?(String)

          next if xss_foliate_options[:except].include?(field)

          next if xss_foliated_with_standard_scrubber(field)

          # :text if we're here
          fragment = Loofah.scrub_fragment(value, :strip)

          text_options = if xss_foliate_is_unencoded(field)
                           {:encode_special_chars => false}
                         else
                           {}
                         end

          self[field] = fragment.nil? ? "" : fragment.text(text_options)
        end
      end

      private

      def xss_foliated_with_standard_scrubber(field)
        Loofah::Scrubbers.scrubber_symbols.each do |method|
          if xss_foliate_options[method].include?(field)
            fragment = Loofah.scrub_fragment(self[field], method)
            self[field] = fragment.nil? ? "" : fragment.to_s
            return true
          end
        end
        false
      end

      def xss_foliate_is_unencoded(field)
        (! xss_foliate_options[:encode_special_chars]) \
        || xss_foliate_options[:unencode_special_chars].include?(field)
      end
    end

    def self.xss_foliate_all_models
      ::ActiveRecord::Base.xss_foliate
    end
  end
end

::ActiveRecord::Base.extend(Loofah::XssFoliate::ClassMethods)

# this file is not require'd from the root.  To use this plugin, run:
#
#    require 'rouge/plugins/redcarpet'

# stdlib
require 'cgi'

module Rouge
  module Plugins
    module Redcarpet
      def block_code(code, language)
        lexer = Lexer.find_fancy(language, code) || Lexers::Text

        # XXX HACK: Redcarpet strips hard tabs out of code blocks,
        # so we assume you're not using leading spaces that aren't tabs,
        # and just replace them here.
        if lexer.tag == 'make'
          code.gsub! /^    /, "\t"
        end

        formatter = Formatters::HTML.new(
          :css_class => "highlight #{lexer.tag}"
        )

        formatter.format(lexer.lex(code))
      end
    end
  end
end

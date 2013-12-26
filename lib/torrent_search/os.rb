require 'rbconfig'

module TorrentSearch
  module OS
    extend RbConfig

    OSES = [:os_x, :windows, :linux]

    class << self

      def os_x?
        match? /darwin/i
      end

      def linux?
        match? /linux|arch/i
      end

      def windows?
        match? /cygwin|mswin|mingw|bccwin|wince|emx/
      end

      def to_s
        CONFIG['host_os']
      end

      def to_sym
        OSES.find {|os| self.send "#{os}?"} || :unknown
      end

      def ==(os)
        meth = "#{os}?"
        respond_to?(meth) && send(meth)
      end

    private
      def match?(regexp)
        !!(to_s =~ regexp)
      end
    end
  end
end
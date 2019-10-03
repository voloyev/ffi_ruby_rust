require 'ffi'

module Server
  extend FFI::Library
  so_extension = case RUBY_PLATFORM
                 when /darwin/
                   'dylib'
                 when /cygwin|mswin|mingw|bccwin|wince|emx/
                   'dll'
                 else
                   'so'
                 end

  ffi_lib "target/release/libfib.#{so_extension}"
  attach_function :server, [], :int
end

Server.server

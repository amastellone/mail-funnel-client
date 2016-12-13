# This modules provides API for RequestStore, in conjunction with the ActiveSupport::PerThreadRegistry API
#
# Instead of polluting the thread locals namespace:
#
#   Thread.current[:connection_handler]
#
# you can define a class that extends ActiveSupport::PerThreadRegistry module.
#
# But if you're using threaded web servers, like Thin or Puma, old values can stick around longer that you'd expect.
#
# The solution to this problem is request_store gem by Steve Klabnik, that makes the global storage local to the request.
#
# You define a class that extends this module:
#
#   module ActiveRecord
#     class RuntimeRegistry
#
#       extend RequestStoreRegistry
#
#       attr_accessor :connection_handler
#     end
#   end
#
# and invoke the declared instance accessors as class methods. So
#
#   ActiveRecord::RuntimeRegistry.connection_handler = connection_handler
#
# sets a connection handler local to the current thread, and
#
#   ActiveRecord::RuntimeRegistry.connection_handler
#
# returns a connection handler local to the current thread.
#
# If the class has an initializer, it must accept no arguments.


  # module ActiveRecord
  #   class RuntimeRegistry
  #
  #     # extend RequestStoreRegistry
  #     # ActionDispatch::Session::ActiveRecordStore
  #     extend ActiveRecordStore
  #
  #     attr_accessor :register_value
  #   end
  # end
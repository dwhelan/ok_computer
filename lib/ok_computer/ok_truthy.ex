# defmodule OkComputer.OkTruthy do
#  defmacro __using__(opts \\ []) do
#    quote do
#      use OkComputer.Railroad
#      import OkComputer.OkNonNil
#
#      def ok?(nil), do: false
#      def ok?(_), do: true
#    end
#  end
# end

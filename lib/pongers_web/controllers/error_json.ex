defmodule PongersWeb.ErrorJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render("401.json", %{error: error}) do
    %{errors: %{detail: "Unauthorized", reason: error}}
  end

  def render("403.json", _assigns) do
    %{
      error: "insufficient_permissions",
      error_description: "Insufficient claim for the token",
      message: "Permission denied"
    }
  end

  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end
end

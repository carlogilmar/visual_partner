defmodule Star.Guardian.BrowserPipeline do
  @moduledoc false
  use Guardian.Plug.Pipeline,
    otp_app: :star,
    module: Star.Guardian,
    error_handler: Star.Guardian.ErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.VerifyHeader, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource, allow_blank: true
end

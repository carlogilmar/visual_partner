defmodule RemoteJobs.EmailManager do
	@moduledoc """
	This module is for send emails with attached file
	"""
	alias Star.Email
	alias Star.Mailer

	def send_email() do
		Email.build("carlogilmar12@gmail.com", "Últimas vacantes publicadas!", "Que onda!!")
		|> Mailer.deliver_now()
	end

end

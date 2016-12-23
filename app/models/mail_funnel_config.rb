class MailFunnelConfig < ApplicationRecord

	def client_installed
		installed = MailFunnelConfig.where(name: "app_installed")
		if installed.any?
		end
	end

end

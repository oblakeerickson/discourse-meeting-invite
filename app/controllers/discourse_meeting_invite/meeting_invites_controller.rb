
module DiscourseMeetingInvite
  class MeetingInvitesController < ::ApplicationController
    before_action :ensure_logged_in

    def oauth2callback
      client_secrets = Google::APIClient::ClientSecrets.load
      auth_client = client_secrets.to_authorization
      auth_client.update!(
        :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
        :redirect_uri => url('/oauth2callback'))
      if request['code'] == nil
        auth_uri = auth_client.authorization_uri.to_s
        redirect to(auth_uri)
      else
        auth_client.code = request['code']
        auth_client.fetch_access_token!
        auth_client.client_secret = nil
        session[:credentials] = auth_client.to_json
        #redirect to('/')
        client_opts = JSON.parse(session[:credentials])
        auth_client = Signet::OAuth2::Client.new(client_opts)
        #service = Google::Apis::CalendarV3::CalendarService.new
      end
      render json: { success: true }
    end
  end
end

# name: DiscourseMeetingInvite
# about: Generates Google Hangouts meeting invites
# version: 0.1
# authors: Blake Erickson
# url: https://github.com/oblakeerickson

gem 'google-api-client', '0.25.0', { require: false }

require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets'

register_asset "stylesheets/common/discourse-meeting-invite.scss"

enabled_site_setting :discourse_meeting_invite_enabled

PLUGIN_NAME ||= "DiscourseMeetingInvite".freeze

after_initialize do

  # see lib/plugin/instance.rb for the methods available in this context

  module ::DiscourseMeetingInvite
    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseMeetingInvite
    end
  end

  require_dependency "application_controller"
  class DiscourseMeetingInvite::ActionsController < ::ApplicationController
    requires_plugin PLUGIN_NAME

    before_action :ensure_logged_in

    def list
      render json: success_json
    end
  end

  require File.expand_path("../app/controllers/discourse_meeting_invite/meeting_invites_controller.rb", __FILE__)

  DiscourseMeetingInvite::Engine.routes.draw do
    get "/list" => "actions#list"
    get "/oauth2callback" => "meeting_invites#oauth2callback"
  end

  Discourse::Application.routes.append do
    mount ::DiscourseMeetingInvite::Engine, at: "/discourse-meeting-invite"
  end

end

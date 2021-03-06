# frozen_string_literal: true

Decidim::DiffCell.include DecidimOCL::DiffCell
Decidim::Proposals::ProposalMCell.include DecidimOCL::Proposals::ProposalMCell
Decidim::ParticipatoryProcesses::ProcessMCell.include DecidimOCL::ParticipatoryProcesses::ProcessMCell
Decidim::Proposals::Admin::ProposalNoteCreatedEvent.prepend DecidimOCL::Proposals::Admin::ProposalNoteCreatedEvent

# Setup a controller hook to setup the sms gateway before the
# request is processed. This is done through a notification to
# get access to the `current_*` environment variables within
# Decidim. Taken and adapted from the term_customizer module.
ActiveSupport::Notifications.subscribe 'start_processing.action_controller' do |_name, _started, _finished, _unique_id, data|
  DecidimOCL::Verifications::Sms::AspsmsGateway.organization = data[:headers].env['decidim.current_organization']
end

module Decidim
  module Map
    module Provider
      module DynamicMap
        autoload :GisLuzern, 'decidim/map/provider/dynamic_map/gis_luzern'
      end
    end
  end
end

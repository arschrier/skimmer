# frozen_string_literal: true

require './skimmer'

def skim_snapshots(event:, context:)
  snapshots_to_skim = []

  ENV['skim_snapshots'].split(', ').each do |droplet_id|
    snapshots_to_skim += skimmable_snapshots(droplet_id)
  end

  snapshots_to_skim.each do |snapshot_id|
    Skimmer.client.snapshots.delete(id: snapshot_id)
  end
end

def skimmable_snapshots(droplet_id)
  snapshots = Skimmer.client.snapshots.all(resource_type: 'droplet')

  # find all snapshots that belong to the droplet
  skimmables = snapshots.sort_by(&:created_at).filter_map do |s|
    s.id if s.resource_id == droplet_id
  end

  # return all but last 2 snapshots
  skimmables.length >= 2 ? skimmables.take(skimmables.length - 2) : []
end

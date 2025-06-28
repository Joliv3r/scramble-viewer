.["schedule"].venues[] |
{
  # venueName: .name,
  sortedEvents: (
    [.rooms[].activities[]] 
    | sort_by(.startTime)
    | map(.name)
  )
}


.["schedule"].venues[] |
{
  # venueName: .name,
  sortedEvents: (
    [.rooms[].activities[] | select(.activityCode | contains("other") | not)]
    | sort_by(.startTime)
    | map(.name)
  )
}


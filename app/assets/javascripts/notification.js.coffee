path = $('#leaflet-map').data('sse-channel')
if path
  source = new EventSource( path )
  console.log "listening on " + path
  source.addEventListener 'geo', (e) ->
    $('#geojson-serialized').val(e.data)

command: "/usr/local/bin/yabai -m query --spaces"

refreshFrequency: 100

removeDuplicates: (ar) ->
  if ar.length == 0
    return []
  res = {}
  res[ar[key]] = ar[key] for key in [0..ar.length-1]
  value for key, value of res

generateIcons: (spaces) ->
  displays = @removeDuplicates((space['display'] for space in spaces))
  iconString = ""
  for display in displays
    for space in spaces when space['display'] == display
      if space['label'] == ""
        space_identifier = space['index']
      else
        space_identifier = space['label']
      iconString += "<li id=\"desktop#{space['index']}\">#{space_identifier}</li>"
    if display < displays.length
      iconString += "<li>•</li>"
  return iconString

render: (output) ->
  spaces = JSON.parse(output)
  htmlString = """
    <div class="spaces-container" data-count="#{spaces.length}">
      <ul>
        #{@generateIcons(spaces)}
      </ul>
    </div>
  """

style: """
  position: relative
  margin-top: 5px
  //text-align: center
  font: 10px "Fira Code", "SF Pro", "HelveticaNeue-Light", "Helvetica Neue Light", "Helvetica Neue", Helvetica, Arial, "Lucida Grande", sans-serif
  color: white
  font-weight: 400

  ul
    list-style: none
    margin: 0 0 0 1em
    padding: 0

  li
    display: inline-block
    text-align: center
    margin: 0 0.5em
    text-shadow: 2px 2px black;

  li.visible
    color: #c83079
"""

update: (output, domEl) ->
  spaces = JSON.parse(output)
  if ($(domEl).find('.spaces-container').attr('data-count') != spaces.length.toString())
    $(domEl).find('.spaces-container').attr('data-count', "#{spaces.length}")
    $(domEl).find('ul').html(@generateIcons(spaces))
  else
    $(domEl).find('li.visible').removeClass('visible')
  for space in spaces when space['visible'] == 1
    $(domEl).find("li#desktop#{space['index']}").addClass('visible')

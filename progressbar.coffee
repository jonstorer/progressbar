$.fn.progressBar = (progress) ->
  isSetup = =>
    @.data('pb-setup') == true

  setup = =>
    @.html "<div class='pb-container'>
              <div class='pb-progress-bar'>
                <div class='pb-progress pb-transition' style='width:0%;display:none;'>
                  <div class='pb-label'>
                  </div>
                </div>
              </div>
            </div>"
    @.data('pb-setup', true)

  setup() unless isSetup()

  bar   = $('.pb-progress', @)
  label = $('.pb-label', @)

  options =
    0:  'red'
    20: 'yellow'
    50: 'blue'
    80: 'green'

  replaceProgressBarColor = (newColor) ->
    for cssClass in bar.attr('class').split(' ')
      if /^pb-color.*$/.test(cssClass)
        bar.removeClass(cssClass)
    bar.addClass("pb-color-#{newColor}")

  setLabelPosition = (bar) ->

    labelPadding = parseInt $(label).css('padding-right')

    labelWidth = ( parseInt $(label).css('width') ) + ( 2 * labelPadding )
    barWidth   = parseInt $(bar).css('width')

    if labelWidth > barWidth
      label.css('margin-right', -1 * labelWidth )
    else
      label.animate('margin-right': 0, 1500, 'swing')

  $('.pb-progress', @).animate width: "#{ progress }%",
    duration: 8000
    easing: 'swing'
    step: (progress) ->
      @.style.overflow = 'visible'

      progress = Math.ceil(progress)

      label.text "#{progress}%"

      setLabelPosition(@)

      if bar.css('width') != '0px'
        bar.show() if bar.is(":hidden")

      color = options[progress]
      replaceProgressBarColor(color) if color?

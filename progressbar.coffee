$.fn.progressBar = (progress) ->
  isSetup = =>
    @.data('pb-setup') == true

  setup = =>
    @.html "<div class='pb-container'>
              <div class='pb-progress-bar'>
                <div class='pb-progress pb-transition' style='width:0%;display:none;float:left;'> </div>
                <div class='pb-label' style='float:left;'> </div>
                <div style='clear:both;'> </div>
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

    labelPadding = parseInt $(label).css('padding-left')
    labelWidth   = parseInt $(label).css('width')
    barWidth     = parseInt $(bar).css('width')

    label.css('margin-left', Math.max(0, barWidth - labelWidth - 2 * labelPadding ))

  $('.pb-progress', @).animate width: "#{ progress }%",
    duration: 8000
    easing: 'swing'
    step: (progress) ->
      @.style.overflow = 'visible'

      progress = Math.ceil(progress)

      label.text "#{progress}%"

      setLabelPosition(@)

      if bar.css('width') == '0px'
        bar.hide() if !bar.is(":hidden")

      if bar.css('width') != '0px'
        bar.show() if bar.is(":hidden")

      color = options[progress]
      replaceProgressBarColor(color) if color?

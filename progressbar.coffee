$.fn.progressBar = (progress) ->
  isSetup = =>
    @.data('pb-setup') == true

  setup = =>
    @.html "<div class='pb-container'>
              <div class='pb-progress-bar'>
                <div class='pb-progress pb-transition' style='width:0%;display:none;'>
                  <div class='pb-label' style='display:none;'>
                  </div>
                </div>
              </div>
            </div>"
    @.data('pb-setup', true)

  setup() unless isSetup()

  options =
    0:  () ->
      removeColorClasses(bar).addClass('pb-color-red')
    20: () ->
      removeColorClasses(bar).addClass('pb-color-yellow')
    50: () ->
      removeColorClasses(bar).addClass('pb-color-blue')
    80: () ->
      removeColorClasses(bar).addClass('pb-color-green')

  removeColorClasses = (bar) ->
    for cssClass in bar.attr('class').split(' ')
      if /^pb-color.*$/.test(cssClass)
        bar.removeClass(cssClass)
    bar

  bar   = $('.pb-progress', @)
  label = $('.pb-label', @)

  $('.pb-progress', @).animate width: "#{ progress }%",
    duration: 2000
    easing: 'swing'
    step: (progress) ->
      progress = Math.ceil(progress)

      if bar.css('width') != '0px'
        bar.show() if bar.is(":hidden")

      transition = options[progress]
      transition() if transition?

      label.text "#{progress}%"

      if progress < 10
        label.fadeOut() if label.is(":visible")
      else
        label.fadeIn() if label.is(":hidden")

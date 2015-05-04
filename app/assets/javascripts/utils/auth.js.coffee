Auth = {}

config = {
  facebook: { width:  980, height: 630 },
  github:   { width: 1060, height: 500 },
  google:   { width:  800, height: 450 },
  hatena:   { width:  940, height: 600 },
  linkedin: { width:  420, height: 630 },
  mixi:     { width:  980, height: 600 },
  twitter:  { width:  600, height: 600 },
}

windowOpen = (linkElementId) ->
  window.authWaiting ||= {}
  $linkElement = $('#' + linkElementId)
  provider = $linkElement.data('provider')
  authUrl = $linkElement.data('url')

  # This function is necessary since Chrome cannot triger beforeunload when user clicks close button
  checkSubwindowClosed = ->
    if window.authWaiting[provider]
      if subwindow.closed
        afterCallback($linkElement, false)
        window.authWaiting[provider] = false
      else
        setTimeout checkSubwindowClosed, 1000

  beforeCallback($linkElement)

  params = "width=#{config[provider]['width']},height=#{config[provider]['height']},resizable,scrollbars=yes,status=1"
  subwindow = window.open(authUrl, provider, params) # set provider to subwindow name
  window.authWaiting[provider] = true

  checkSubwindowClosed()

beforeCallback = ($linkElement) ->
  $linkElement.text(I18n.t('auth.connecting'))
  $linkElement.attr('disabled', 'disabled')

afterCallback = ($linkElement, success) ->
  if success
    $linkElement.text(I18n.t('auth.connected'))
    $linkElement.attr('disabled', 'disabled')
  else
    $linkElement.text(I18n.t('auth.connect'))
    $linkElement.removeAttr('disabled')

$(document).on('click', '.social-connect', () ->
  windowOpen($(this).attr('id'));
)

mq = window.matchMedia( "(max-width: 768px)" )
$(document).ready ->
  if not mq.matches
    $(document.getElementById('feature-video')).addClass('video')
    setActiveFeature(0)
  else
    setFeatures()
  
@setActiveFeature = (n) ->
  feats = document.getElementsByClassName("feat-objects")
  url = feats[n].getElementsByClassName('thumbnail-url')[0].innerHTML;
  document.getElementById("feature-video").innerHTML = '<p class="ss-video-container" onclick="playVid(' + n + ')"><img alt="picture of student" src="' + url + '" /></p>'
  feat.className = feat.className.replace " active", "" for feat in feats
  feats[n].className += " active"
  
  html = ""
  for i in [0...feats.length]
    if not feats[i].classList.contains "active"
      html += '<img src="' + feats[i].getElementsByClassName("thumbnail-url")[0].innerHTML + '" class="preview-item champ-card" onclick="setActiveFeature(' + i + ')" />'
  
  document.getElementById("preview-container").innerHTML = html
  return

@playVid = (n) ->
  document.getElementsByClassName('ss-video-container')[0].innerHTML =
    '<div class="video"><iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
      document.getElementsByClassName("feat-objects")[n].getElementsByClassName('video-url')[0].innerHTML +
      '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe></div>'
  setIFrameRatio()
  return

@setIFrameRatio = () ->
  document.getElementsByClassName('ss-player')[0].style.height = ($(document.getElementsByClassName('ss-player')[0]).width() * 9 / 16) + 'px'
  return
  
@setFeatures = () ->
  feats = document.getElementsByClassName("feat-objects")
  i = 0
  while i < feats.length
    document.getElementById("feature-video").innerHTML += '<div class="video" onclick="playMobileVid(' + i + ')"><img alt="picture of student" src="' + feats[i].getElementsByClassName('thumbnail-url')[0].innerHTML + '" /></div>'
    i++
  $('<br /><div class="dots"></div>').insertAfter('.left-btn')
  return
  
@playMobileVid = (n) ->
  document.getElementById('feature-video').getElementsByClassName('video')[n].innerHTML =
    '<iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
      document.getElementsByClassName("feat-objects")[n].getElementsByClassName('video-url')[0].innerHTML +
      '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe>'
  setIFrameRatio()
  return
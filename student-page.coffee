$(document).ready ->
  container = document.getElementsByClassName('student-container')[0]
  dataSource = document.getElementsByClassName('student-profile')[0]
  tempHTML = '<h1 class="ss-title">MEET ' + dataSource.getElementsByClassName('ss-name')[0].innerHTML + ', ' +
    dataSource.getElementsByClassName('ss-grad')[0].innerHTML + '</h1>' +
    '<h2 class="ss-subtitle">' + dataSource.getElementsByClassName('ss-major')[0].innerHTML + '<br />' +
    dataSource.getElementsByClassName('ss-home')[0].innerHTML + '</h2>' + '<div class="dots"></div>'
  if dataSource.getElementsByClassName('ss-video-thumb').length is 1
    tempHTML += '<div onclick="playVid()" class="ss-video-container"><img class="ss-vid-thumb" alt="student video thumb" src="' +
      dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div class="dots"></div>'
  else if dataSource.getElementsByClassName('ss-video-thumb').length is 2
    tempHTML += '<div class="video-wrapper-wrapper"><div class="video-wrapper" onclick="selectVid(this)" id="video-left">' +
      '<img class="video-thumb" alt="student video thumb" src="' +
      dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div class="video-wrapper" onclick="selectVid(this)" id="video-right">' +
      '<img class="video-thumb" alt="student video thumb" src="' +
      dataSource.getElementsByClassName('ss-video-thumb')[1].innerHTML + '" /></div></div><div class="dots"></div>'
  tempHTML += '<p class="ss-quote">' + dataSource.getElementsByClassName('ss-quote')[0].innerHTML + '</p>' +
      '<a href="x36256"><img alt="call to action button" src="images/ace/student-stories-dev/gallery-button-01.jpg" onmouseover="this.src=\'images/ace/student-stories-dev/gallery-button-02.jpg\';" onmouseout="this.src=\'images/ace/student-stories-dev/gallery-button-01.jpg\'" /></a>'
  container.innerHTML = tempHTML
  if document.getElementsByClassName('video-wrapper-wrapper').length
    $('.video-wrapper-wrapper').height($('.video-wrapper').outerHeight())
  return

@playVid = () ->
  document.getElementsByClassName('ss-video-container')[0].innerHTML =
    '<iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
    document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[0].innerHTML +
    '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe>'
  setIFrameRatio()
  return
  
@selectVid = (video) ->
  if $('.video-wrapper').length > 1
    if not $('.active').length
      $('.video-wrapper-wrapper').stop().animate({
        height: $('.video-wrapper-wrapper').outerHeight() * 1.52
      }, {duration: 200, queue: false})
    if ($(video).is '#video-left') and (not $(video).hasClass 'active')
      document.getElementById('video-right').innerHTML = '<img class="video-thumb" src="' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-thumb')[1].innerHTML +
          '" alt="student video thumbnail" />'
      $('#video-left').stop().animate({
        width: '78%',
      }, {duration: 200, queue: false})
      $('#video-right').stop().animate({
        width: '25%'
      }, {duration: 200, queue: false})
      $(video).addClass 'active'
      if $('#video-right').hasClass 'active'
        $('#video-right').removeClass 'active'
      document.getElementById('video-left').innerHTML = '<iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[0].innerHTML +
          '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe>'
    
    else if ($(video).is '#video-right') and (not $(video).hasClass 'active')
      document.getElementById('video-left').innerHTML = '<img class="video-thumb" src="' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-thumb')[0].innerHTML +
          '" alt="student video thumbnail" />'
      $('#video-left').stop().animate({
        width: '25%'
      }, {duration: 200, queue: false})
      $('#video-right').stop().animate({
        width: '78%'
      }, {duration: 200, queue: false})
      $(video).addClass 'active'
      if $('#video-left').hasClass 'active'
        $('#video-left').removeClass 'active'
      document.getElementById('video-right').innerHTML = '<iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[1].innerHTML +
          '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe>'
  setTimeout(setIFrameRatio, 200)
  return
  
@setIFrameRatio = () ->
  document.getElementsByClassName('ss-player')[0].style.height = ($(document.getElementsByClassName('ss-player')[0]).width() * 9 / 16) + 'px'
  return
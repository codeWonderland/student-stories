mq = window.matchMedia( "(max-width: 768px)" )
$(document).ready ->
  container = document.getElementsByClassName('student-container')[0]
  dataSource = document.getElementsByClassName('student-profile')[0]
  
  # Inserting Intro Section
  tempHTML = '<h1 class="ss-title">MEET ' + dataSource.getElementsByClassName('ss-name')[0].innerHTML + ', ' +
    dataSource.getElementsByClassName('ss-grad')[0].innerHTML + '</h1>' +
    '<h2 class="ss-subtitle">' + dataSource.getElementsByClassName('ss-major')[0].innerHTML + '<br />' +
    dataSource.getElementsByClassName('ss-home')[0].innerHTML + '</h2>' + '<div class="dots"></div>'
  
  if mq.matches
    #If one video only
    if dataSource.getElementsByClassName('ss-video-thumb').length is 1
      tempHTML += '<div onclick="playVid()" class="ss-video-container"><img class="ss-vid-thumb" alt="student video thumb" src="' +
        dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div class="dots"></div>'
    
    # If two videos on mobile
    else if dataSource.getElementsByClassName('ss-video-thumb').length is 2 and mq.matches
      tempHTML += '<div onclick="playVid(0)" class="ss-video-container"><img alt="student video thumb" class="ss-vid-thumb"' +
        'src="' + dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div onclick="playVid(1)" class="ss-video-container">' +
        '<img alt="student video thumb" class="ss-vid-thumb" src="' + dataSource.getElementsByClassName('ss-video-thumb')[1].innerHTML +
        '" /></div><div class="dots"></div>'
    
    # Else Inserting Photo
    else tempHTML += '<img class="student-photo" src="' + dataSource.getElementsByClassName('ss-image')[0].innerHTML + '" />'

    # Inserting Short Quote
    tempHTML += '<p class="ss-squote">' + dataSource.getElementsByClassName('ss-squote')[0].innerHTML + '</p><div class="dots"></div>'
    
    # Inserting Quote
    tempHTML += '<p class="ss-quote">' + dataSource.getElementsByClassName('ss-quote')[0].innerHTML + '</p><div class="dots"></div>'
    
    
    # Inserting Link
    tempHTML += '<a href="x36256.xml" class="meetStudentsButton"><img alt="call to action button" src="images/ace/student-stories-dev/gallery-button-01.jpg" onmouseover="this.src=\'images/ace/student-stories-dev/gallery-button-02.jpg\';" onmouseout="this.src=\'images/ace/student-stories-dev/gallery-button-01.jpg\'" /></a>'
    
  else
    #If one video only
    if dataSource.getElementsByClassName('ss-video-thumb').length is 1
      tempHTML += '<div onclick="playVid()" class="ss-video-container"><img class="ss-vid-thumb" alt="student video thumb" src="' +
          dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div class="dots"></div>'

    # If two videos on desktop
    else if dataSource.getElementsByClassName('ss-video-thumb').length is 2 and not mq.matches
      tempHTML += '<div class="video-wrapper-wrapper"><div class="video-wrapper" onclick="selectVid(this)" id="video-left">' +
          '<img class="video-thumb" alt="student video thumb" src="' +
          dataSource.getElementsByClassName('ss-video-thumb')[0].innerHTML + '" /></div><div class="video-wrapper" onclick="selectVid(this)" id="video-right">' +
          '<img class="video-thumb" alt="student video thumb" src="' +
          dataSource.getElementsByClassName('ss-video-thumb')[1].innerHTML + '" /></div></div><div class="dots"></div>'
    # Inserting Quote
    tempHTML += '<p class="ss-quote">' + dataSource.getElementsByClassName('ss-quote')[0].innerHTML + '</p>'
    
    # Inserting Link
    tempHTML += '<a href="x36256.xml"><img alt="call to action button" src="images/ace/student-stories-dev/gallery-button-01.jpg" onmouseover="this.src=\'images/ace/student-stories-dev/gallery-button-02.jpg\';" onmouseout="this.src=\'images/ace/student-stories-dev/gallery-button-01.jpg\'" /></a>'
  
  
  # Putting html into the DOM
  container.innerHTML = tempHTML
  
  # If this is desktop and there are two videos then we need to adjust the height of the surrounding container to
  # Compensate for the fact that the videos are floating
  if not mq.matches and document.getElementsByClassName('ss-video-thumb').length > 1
    setTimeout(setVideoContainer, 2000)
  return

@setVideoContainer = () ->
  $('.video-wrapper-wrapper').height($('.video-wrapper').outerHeight())
  return
  
@playVid = (n = 0) ->
  document.getElementsByClassName('ss-video-container')[n].innerHTML =
    '<div class="video"><iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
    document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[n].innerHTML +
    '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe></div>'
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
      document.getElementById('video-left').innerHTML = '<div class="video"><iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[0].innerHTML +
          '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe></div>'
    
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
      document.getElementById('video-right').innerHTML = '<div class="video"><iframe class="ss-player" frameborder="0" height="562.5" src="https://player.vimeo.com/video/' +
          document.getElementsByClassName('student-profile')[0].getElementsByClassName('ss-video-link')[1].innerHTML +
          '?color=ffffff&amp;title=0&amp;byline=0&amp;portrait=0&amp;autoplay=1" width="1000"></iframe></div>'
  setTimeout(setIFrameRatio, 200)
  return
  
@setIFrameRatio = () ->
  document.getElementsByClassName('ss-player')[0].style.height = ($(document.getElementsByClassName('ss-player')[0]).width() * 9 / 16) + 'px'
  return
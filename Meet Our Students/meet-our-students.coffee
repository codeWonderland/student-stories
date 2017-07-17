mq = window.matchMedia( "(max-width: 768px)" )
$container = $('.photo-container')[0]

$(document).ready ->
  if mq.matches
    if sessionStorage.getItem("photoIndex") is null
      sessionStorage.setItem("photoIndex", 0)
    $container.innerHTML = '<p class="end-text">Oh hey, you\'ve gone <br /> through \'em all</p><a class="btn center-btn" onclick="refreshStack()">Start Over</a>'
    initStack(parseInt(sessionStorage.getItem("photoIndex")))
    i = 0
    while i < parseInt(sessionStorage.getItem("photoIndex"))
      removeLast()
      i++
  
    $($('.photo-container')[0]).find('img:last').animate(
      '-moz-transform': 'rotate(0deg)'
      '-webkit-transform': 'rotate(0deg)'
      'transform': 'rotate(0deg)')
  return
  
@refreshStack = () ->
  sessionStorage.setItem("photoIndex", 0)
  initStack(0)
  
@initStack = (n) ->
  $src = $('.student-table')[0]
  data = reverseArray($src.getElementsByTagName('img'))
  cnt = 0
  for datum in data
    $image = new Image()
    $image.src = datum.getAttribute('src')
    ++cnt
    $image = resizeCenterImage($image)
    $($image).attr('onclick', datum.getAttribute('onclick'))
    $container.append($image)
    
    r		= Math.floor(Math.random()*41)-20
    if cnt < data.length
      $($image).css({
        '-moz-transform'	:'rotate('+r+'deg)',
        '-webkit-transform'	:'rotate('+r+'deg)',
        'transform'			:'rotate('+r+'deg)'
      })
  
  initHammer(photo) for photo in document.getElementsByClassName('photo-container')[0].getElementsByTagName('img')
  return

@reverseArray = (array) ->
  i = array.length
  temp = []
  while i >= 0
    temp.push(array[i])
    i--
  temp.shift()
  return temp
  
@initHammer = (el) ->
  mc = new Hammer.Manager(el)
  mc.add( new Hammer.Swipe() )
  mc.on 'swiperight', nextPhoto
  return

@nextPhoto = () ->
  nextIndex = parseInt(sessionStorage.getItem("photoIndex")) + 1
  sessionStorage.setItem("photoIndex", nextIndex)
  $current 	= $($('.photo-container')[0]).find('img:last')
  $new_current = $current.prev()
  $current.animate {
    'marginLeft': '250px'
    'marginTop': '-385px'
  }, 500
  
  $new_current.css(
    '-moz-transform': 'rotate(0deg)'
    '-webkit-transform': 'rotate(0deg)'
    'transform': 'rotate(0deg)')
  
  setTimeout(removeLast, 600)
  return

@removeLast = () ->
  $($('.photo-container')[0]).find('img:last').remove()
  return

@resizeCenterImage = ($image) ->
  theImage 	= new Image()
  theImage.src 	= $image.getAttribute("src")
  imgwidth 	= theImage.width
  imgheight 	= theImage.height
  
  containerwidth  = 330
  containerheight = 230
  
  if imgwidth	> containerwidth
    newwidth = containerwidth
    ratio = imgwidth / containerwidth
    newheight = imgheight / ratio
    if(newheight > containerheight)
      newnewheight = containerheight
      newratio = newheight/containerheight
      newnewwidth =newwidth/newratio
      theImage.width = newnewwidth
      theImage.height= newnewheight
    
    else
      theImage.width = newwidth
      theImage.height= newheight
  
  
  else if imgheight > containerheight
    newheight = containerheight
    ratio = imgheight / containerheight
    newwidth = imgwidth / ratio
    if newwidth > containerwidth
      newnewwidth = containerwidth
      newratio = newwidth/containerwidth
      newnewheight =newheight/newratio
      theImage.height = newnewheight
      theImage.width= newnewwidth
    
    else
      theImage.width = newwidth
      theImage.height= newheight
  
  
  $($image).css({
    'width'			:theImage.width,
    'height'		:theImage.height,
    'margin-top'	:-(theImage.height/2)-10+'px',
    'margin-left'	:-(theImage.width/2)-10+'px'
  })
  return $image
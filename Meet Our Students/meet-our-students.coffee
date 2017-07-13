mq = window.matchMedia( "(max-width: 768px)" )
$container = $('.photo-container')[0]

$(document).ready ->
  if mq.matches
    $container.innerHTML = '<p class="end-text">Oh hey, you\'ve gone <br /> through \'em all</p><a class="btn center-btn" onclick="initStack()">Start Over</a>'
    initStack()
  return

@initStack = () ->
  $src = $('.student-table')[0]
  data = $src.getElementsByTagName('img')
  data = reverseArray(data)
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
  mc.on 'swipe', nextPhoto
  return

@nextPhoto = () ->
  $current 	= $($('.photo-container')[0]).find('img:last')
  $new_current = $current.prev()
  $current.animate {
    'marginLeft': '250px'
    'marginTop': '-385px'
  }, 1000
  
  $new_current.css(
    '-moz-transform': 'rotate(0deg)'
    '-webkit-transform': 'rotate(0deg)'
    'transform': 'rotate(0deg)')
  
  setTimeout(removeLast, 1100)
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
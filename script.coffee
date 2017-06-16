$(document).ready ->
  setActiveFeature(0)
  
@setActiveFeature = (n) ->
  feats = document.getElementsByClassName("feat-objects")
  url = feats[n].getElementsByClassName('video-url')[0].innerHTML;
  document.getElementById("feature-video").innerHTML = '<p><iframe frameborder="0" height="562.5" src="' + url + '" width="1000"></iframe></p>'
  feat.className = feat.className.replace " active", "" for feat in feats
  feats[n].className += " active"
  
  html = ""
  for i in [0...feats.length]
    if not feats[i].classList.contains "active"
      html += '<img src="' + feats[i].getElementsByClassName("thumbnail-url")[0].innerHTML + '" class="preview-item champ-card" onclick="setActiveFeature(' + i + ')" />'
  
  document.getElementById("preview-container").innerHTML = html
  return
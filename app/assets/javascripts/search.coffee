@sortJobs =(sort)->
  url=window.location.href
  b=url.indexOf('sort=')
  if b!=-1
    url=url.substring(0,b-1)
  console.log '1 :'+url    
  if window.location.search=="" || window.location.search=="?sort=date" || window.location.search=="?sort=relevance"
     url=url+"?"
  else  
    url=url+"&"    
  console.log '2:'+url
  if sort=='relevance'
     window.location.href=url+'sort=relevance'
  else  
    window.location.href=url+'sort=date'
#!/bin/sh

#http://yost.com/computers/MacStuff/reveal/index.html


#-----------------------------------------

# unix path -> old-style Mac path for AppleScript
colonize() {
  sed 's,.*,"&",
       s,/,\&,g
       s,:,/,g
       s,^"&Volumes&,",
       s,^"&.*,& of startup disk,' \
  | sed 's,&,:,g' \
  | tr -d '\012'
}

# Reveal unix paths in the Finder
reveal() {
  if [ $# = 0 ] ; then
    args=( . )
  else
    args=( $* )
  fi

  itemList=
  for x in $args
  do
    case "$x" in
    /*) item="$x" ;;
    .)  item="`/bin/pwd`" ;;
    *)  item="`/bin/pwd`/$x" ;;
    esac
    
    # All /x/../ -> /
    previtem=
    while [ "$previtem" != "$item" ]
    do
      previtem="$item"
      item=`echo "$item" | sed 's,[^/]*/\.\./,,'`
    done
    
    if [ $item = / ] ; then
      itemColonized="startup disk"
    else
      itemColonized="item $(echo  $item | colonize)"
    fi
    
    # Add it to the list
    if [ "$itemList" = "" ] ; then
      itemList="      $itemColonized"
    else
      itemList="$itemList, 
      $itemColonized"
    fi
  done
  
  script='
  tell application "Finder"
    reveal { '$itemList'    }'

#  if [ "$#argList" != 0 ] ; then
#    script="$script
#    get every Finder window whose index is 1
#    set the current view of item 1 of the result to list view"
#  fi

  script="$script"'
    activate
  end tell'

#  if [[ $#argVerbose != 0 ]] ; then
    echo 1>&2 "[osascript -e '$script
']"
# fi

  osascript -e "$script"
}


case $# in
0) reveal "`/bin/pwd`"
	;;
*) reveal $*
	;;
esac

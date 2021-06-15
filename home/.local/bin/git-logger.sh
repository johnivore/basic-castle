#!/usr/bin/env bash

# git-logger is free software and is licensed under the GNU GPLv2+.
# (C) 2018-2019 Nuno Ferreira and contributors
# Contributors: James Brown, 
#               qZeta 
#               boweeb1011
#               Mathias Weber
                
function on_exit {
    status=$?
    if [[ -f "$tmp_file" ]]; then
        rm -rf "$tmp_file"
    fi
    if [[ -f "$tmp_file_2" ]]; then
        rm -rf "$tmp_file_2"
    fi
    exit $status
}

trap on_exit EXIT SIGINT SIGTERM

days=' '$(date -d monday +%a)' '$(date -d tuesday +%a)' '$(date -d wednesday +%a)' '$(date -d thursday +%a)' '$(date -d friday +%a)' '$(date -d saturday +%a)' '$(date -d sunday +%a)' ' # this should work for international system locales

hours='01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 22 23 00'
colors=(19 21 23 25 27 30 36 39 41 49 51 154 178 172 166 202 196)
max_hourly_commit=0
total_commits=0
total_daily_commits=0

# save a text file containing the "git log --pretty=format". The file has a random name and is located in the /tmp folder.
tmp_file="$(mktemp -t tmp_XXXXXXXX)"
tmp_file_2="$(mktemp -t tmp_XXXXXXXX)"

if [ -d ".git" ]; then
  git log --pretty=format:"%ad" --date=local --date=format:'%a %H'> "$tmp_file"
elif [ -d ".hg" ]; then
  hg log --template "{date|isodate}\n" | date "+%a %H" -f - > "$tmp_file"
else
  echo "Could not find a git or mercurial repository"
  exit 1
fi

# This function saves the hourly commits in memory and finds the max hourly commit value used for plotting
function find_max {

  for day in $days; do

    # save another text file containing the filtered commits submitted on $day.
    grep "$day" "$tmp_file" > "$tmp_file_2"

    for hour in $hours; do
      # search "tmp_file" file for commits submitted at $hour
      number_hourly_commits=$(grep -c "$hour" "$tmp_file_2")

      if [ "$number_hourly_commits" -gt "$max_hourly_commit" ]
        then
        max_hourly_commit="$number_hourly_commits"
      fi

    done
  done
}

no_color=$(tput sgr0)

function 256_color_display {

  printf "\n%s\n" "                          ****** Punch card for $(basename "$PWD") ******                             "
  printf "\n%s\n%s" "      ------------------------------------time of day (hours)-----------------------------------------" "      "

  for hour in $hours; do
    printf "%s" "| $hour" # display array with the hours
  done
  printf "| Total"

  for day in $days; do
    printf "\n%s" " $day -"
   
    grep "$day" "$tmp_file" > "$tmp_file_2" # save another text file containing the filtered commits submitted on $day.

    for hour in $hours; do
     
      number_hourly_commits=$(grep -c "$hour" "$tmp_file_2") # search "tmp_file_2" file for commits submitted at $hour
      color=$(tput setab "${colors[$((16*number_hourly_commits/(max_hourly_commit)))]}") # colorize a given color array index given by 16*$number_hourly_commits/($max_hourly_commit)
     
      if [ "$number_hourly_commits" -eq 0 ]; then  # print for 0 commits
        printf "%s" "  $number_hourly_commits " #  do not colorize
      elif [ "$number_hourly_commits" -lt 1000 ]; then
        printf "%s%4s%s" "${color}$(tput setaf 0)" "$((number_hourly_commits))" "${no_color}" # print for < 1000 commits
      else
        printf "%s%4s%s" "${color}$(tput setaf 0)" "$((number_hourly_commits/1000))k" "${no_color}" # print for > 1000 commits
      fi

      (( total_commits=total_commits+number_hourly_commits ))
      (( total_daily_commits=total_daily_commits+number_hourly_commits ))
    done

    printf "%s" "|  $total_daily_commits " #  do not colorize
    total_daily_commits=0
  done

  printf "\n\n%s\n\n" "total_commits = $total_commits"
}

function 8_color_display {

  for day in $days; do
    printf "\n%s" " $day -"
    grep "$day" "$tmp_file" > "$tmp_file_2" # save a text file containing the commits submitted on $day

    for hour in $hours; do
      number_hourly_commits=$(grep -c "$hour" "$tmp_file_2") # search "tmp_file" file for commits submitted at $hour

      if [ "$number_hourly_commits" -eq 0 ]; then
        printf "%s" "  $number_hourly_commits " #  do not colorize
      elif [ "$number_hourly_commits" -lt 10 ]; then
        printf "%4s" "$(tput setab 2) $(tput setaf 0) $number_hourly_commits $(tput sgr0)" # colorize green
      elif [ "$number_hourly_commits" -lt 100 ]; then
        printf "%4s" "$(tput setab 3) $(tput setaf 0) $number_hourly_commits $(tput sgr0)" # colorize yellow
      else
        printf "%4s" "$(tput setab 1) $(tput setaf 0) $number_hourly_commits $(tput sgr0)" # colorize red
      fi

      (( total_commits=total_commits+number_hourly_commits ))
      (( total_daily_commits=total_daily_commits+number_hourly_commits ))
    done

    printf "%s" "|  $total_daily_commits " #  do not colorize
    total_daily_commits=0
  done

  printf "\n\n%s\n\n" "Total number of commits is $total_commits"
}

if [ "$(tput colors)" -eq 256 ];then # check if 256 color are supported
  find_max
  256_color_display
else
  8_color_display
  printf "\n%s\n\n" "####### 8 color display detected. For best results try 256 color display #######"
fi

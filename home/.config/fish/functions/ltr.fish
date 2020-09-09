# Defined in - @ line 1
function ltr --wraps='ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhFtr' --description 'alias ltr ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhFtr'
  ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhFtr $argv;
end

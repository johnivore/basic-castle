# Defined in - @ line 1
function lss --wraps='ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhF' --wraps='ls -F --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhF' --description 'alias lss ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhF'
  ls --group-directories-first --color=always --time-style=+"%Y-%m-%d %H:%M:%S" -lhF $argv;
end

# Defined in - @ line 1
function lst --wraps='ls -al --color -F --sort=t | head' --wraps='ls -al --color -F --sort=t | head -20' --description 'alias lst ls -al --color -F --sort=t | head -20'
  ls -al --color -F --sort=t | head -20 $argv;
end

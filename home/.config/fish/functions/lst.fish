# Defined in - @ line 1
function lst --wraps='ls -al --color -F --sort=t | head' --description='List most recent files'
  ls -al --color -F --sort=t | head -20 $argv;
end

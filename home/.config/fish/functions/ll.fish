# Defined in - @ line 1
function ll --wraps='ls -F --color -la' --description 'alias ll ls -F --color -la'
  ls -F --color -la $argv;
end

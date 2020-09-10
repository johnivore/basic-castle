# Defined in - @ line 1
function ls --wraps='ls -F --color' --description 'alias ls ls -F --color'
    command ls -F --color $argv;
end

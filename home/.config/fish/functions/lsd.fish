# Defined in - @ line 1
function lsd --wraps='ls -lF --color | grep --color=never "^d"' --description 'list only directories'
    ls -lF --color $argv | grep --color=never "^d";
end

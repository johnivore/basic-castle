# Defined in - @ line 1
function ll --wraps='ls -F --color -la' --description 'ls with details'
    ls -F --color -la $argv;
end

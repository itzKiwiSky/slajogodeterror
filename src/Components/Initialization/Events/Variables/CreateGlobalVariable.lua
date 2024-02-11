return function(_name, _value)
    local val
    if type(tonumber(_value)) == "number" then
        val = tonumber(_value)
    else
        val = tostring(_value)
    end
    registers.game.globalvaribles[_name] = val
end
CelsiusTemperature = Origin mimic do(
    value = 0
    initialize = method(value, @value = value)
    asText = method("#{value}ºC")
    cell(:"==") = method(other, @kind == other kind && @value == other value)
)

Message OperatorTable operators[:"ºC"] = 1

Number ºC = method(CelsiusTemperature mimic(self))

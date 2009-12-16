CelsiusTemperature = Origin mimic do(
    degrees = 0
    initialize = method(degrees, @degrees = degrees)
    asText = method("#{degrees}ºC")
    cell("==") = method(other, @kind == other kind && @degrees == other degrees)
    cell("+") = method(other, CelsiusTemperature mimic(@degrees + other degrees))
    cell("-") = method(other, CelsiusTemperature mimic(@degrees - other degrees))
    negation = method(CelsiusTemperature mimic(@degrees negation))
)

Message OperatorTable operators[:"ºC"] = 1

Number ºC = method(CelsiusTemperature mimic(self))

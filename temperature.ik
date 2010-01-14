;; conditions
Condition Error NegativeKelvin = Condition Error mimic


;; temperature objects
Temperature = Origin mimic do(
    degrees = 0
    symbol = ""
    initialize = method(degrees 0, @degrees = degrees)
    asText = method("#{degrees}#{symbol}")
    cell("==") = method(other, @kind == other kind && @degrees == other degrees)
    cell("+") = method(other, mimic(@degrees + other degrees))
    cell("-") = method(other, mimic(@degrees - other degrees))
    negation = method(mimic(@degrees negation))
)

CelsiusTemperature = Temperature mimic do(
    symbol = "ºC"
    inCelsius = method(self)
    inFahrenheit = method(FahrenheitTemperature mimic(9 * @degrees / 5.0 + 32))
    inKelvin = method(KelvinTemperature mimic(@degrees + 273))
)

FahrenheitTemperature = Temperature mimic do(
    symbol = "ºF"
    inCelsius = method(CelsiusTemperature mimic(5 / 9.0 * (@degrees - 32)))
    inFahrenheit = method(self)
    inKelvin = method(inCelsius inKelvin)
)

KelvinTemperature = Temperature mimic do(
    symbol = "K"
    inCelsius = method(CelsiusTemperature mimic(@degrees - 273))
    inFahrenheit = method(inCelsius inFahrenheit)
    inKelvin = method(self)
    before(:-) << method(other, if(@degrees - other degrees < 0, error!(Condition Error NegativeKelvin)))
    before(:negation) << method(error!(Condition Error NegativeKelvin))
    before(:mimic) << method(degrees, if(degrees < 0, error!(Condition Error NegativeKelvin)))
)


;; literal temperature support
Message OperatorTable do(
    operators[CelsiusTemperature symbol] = 1
    operators[FahrenheitTemperature symbol] = 1
    operators[KelvinTemperature symbol] = 1
)

Number do( 
    cell(CelsiusTemperature symbol) = method(CelsiusTemperature mimic(self))
    cell(FahrenheitTemperature symbol) = method(FahrenheitTemperature mimic(self))
    cell(KelvinTemperature symbol) = method(KelvinTemperature mimic(self))
)    

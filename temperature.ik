;; conditions
Condition Error NegativeKelvin = Condition Error mimic


;; temperature objects
Temperature = Origin mimic do(
    _degrees = 0
    _symbol = ""
    initialize = method(_degrees 0, @_degrees = _degrees)
    asText = method("#{_degrees}#{_symbol}")
    cell("==") = method(other, @kind == other kind && @_degrees == other _degrees)
    cell("+") = method(other, mimic(@_degrees + other _degrees))
    cell("-") = method(other, mimic(@_degrees - other _degrees))
    negation = method(mimic(@_degrees negation))
)

CelsiusTemperature = Temperature mimic do(
    _symbol = "ºC"
    inCelsius = method(self)
    inFahrenheit = method(FahrenheitTemperature mimic(9 * @_degrees / 5.0 + 32))
    inKelvin = method(KelvinTemperature mimic(@_degrees + 273))
)

FahrenheitTemperature = Temperature mimic do(
    _symbol = "ºF"
    inCelsius = method(CelsiusTemperature mimic(5 / 9.0 * (@_degrees - 32)))
    inFahrenheit = method(self)
    inKelvin = method(inCelsius inKelvin)
)

KelvinTemperature = Temperature mimic do(
    _symbol = "K"
    inCelsius = method(CelsiusTemperature mimic(@_degrees - 273))
    inFahrenheit = method(inCelsius inFahrenheit)
    inKelvin = method(self)
    before("-") << method(other, if(@_degrees - other _degrees < 0, error!(Condition Error NegativeKelvin)))
    before("negation") << method(error!(Condition Error NegativeKelvin))
    before("mimic") << method(_degrees, if(_degrees < 0, error!(Condition Error NegativeKelvin)))
)


;; literal temperature support
Message OperatorTable do(
    operators[CelsiusTemperature _symbol] = 1
    operators[FahrenheitTemperature _symbol] = 1
    operators[KelvinTemperature _symbol] = 1
)

Number do( 
    cell(CelsiusTemperature _symbol) = method(CelsiusTemperature mimic(self))
    cell(FahrenheitTemperature _symbol) = method(FahrenheitTemperature mimic(self))
    cell(KelvinTemperature _symbol) = method(KelvinTemperature mimic(self))
)    

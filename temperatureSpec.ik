use("ispec")
use("temperature")

describe("ºC",
    it("should create a CelsiusTemperature object",
        integerTemperatureObject = CelsiusTemperature mimic(10)
        integerTemperatureLiteral = 10ºC
        integerTemperatureLiteral should == integerTemperatureObject
        
        decimalTemperatureObject = CelsiusTemperature mimic(40.5)
        decimalTemperatureLiteral = 40.5ºC
        decimalTemperatureLiteral should == decimalTemperatureObject
        
        literalTemperatureWithSpace = 30.1 ºC
        literalTemperatureWithSpace should == CelsiusTemperature mimic(30.1)
    )
)

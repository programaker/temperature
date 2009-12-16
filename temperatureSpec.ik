use("ispec")
use("temperature")

describe("Temperature DSL",
    describe("ºC",
        it("should create a CelsiusTemperature from an integer value",
            t1 = CelsiusTemperature mimic(10)
            t2 = 10ºC
            t2 should == t1
        )
        
        it("should create a CelsiusTemperature from a decimal value",
            t1 = CelsiusTemperature mimic(40.5)
            t2 = 40.5ºC
            t2 should == t1
        )
        
        it("should create a CelsiusTemperature when there's a blank space between value and symbol",
            t1 = CelsiusTemperature mimic(10)
            t2 = 10 ºC
            t2 should == t1
            
            t3 = CelsiusTemperature mimic(40.5)
            t4 = 40.5 ºC
            t4 should == t3
        )
        
        it("should create a CelsiusTemperature from a variable",
            v1 = 40
            t1 = v1ºC
            t1 should == CelsiusTemperature mimic(40)
            
            v2 = 15.5
            t2 = v2 ºC
            t2 should == CelsiusTemperature mimic(15.5)
        )
    )
    
    describe("+",
        it("should return the sum of two temperatures",
            (2ºC + 40.5ºC) should == 42.5ºC
        )
    )
    
    describe("-",
        it("should return the difference of two temperatures",
            (40.5ºC - 10ºC) should == 30.5ºC
            (0ºC - 10ºC) should == -10ºC
        )
    )
)    

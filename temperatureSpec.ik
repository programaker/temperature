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
    
    describe("ºF",
        it("should create a FahrenheitTemperature from an integer value",
            t1 = FahrenheitTemperature mimic(10)
            t2 = 10ºF
            t2 should == t1
        )
        
        it("should create a FahrenheitTemperature from a decimal value",
            t1 = FahrenheitTemperature mimic(40.5)
            t2 = 40.5ºF
            t2 should == t1
        )
        
        it("should create a FahrenheitTemperature when there's a blank space between value and symbol",
            t1 = FahrenheitTemperature mimic(10)
            t2 = 10 ºF
            t2 should == t1
            
            t3 = FahrenheitTemperature mimic(40.5)
            t4 = 40.5 ºF
            t4 should == t3
        )
        
        it("should create a FahrenheitTemperature from a variable",
            v1 = 40
            t1 = v1ºF
            t1 should == FahrenheitTemperature mimic(40)
            
            v2 = 15.5
            t2 = v2 ºF
            t2 should == FahrenheitTemperature mimic(15.5)
        )
    )
    
    describe("K",
        it("should create a KelvinTemperature from an integer value",
            t1 = KelvinTemperature mimic(10)
            t2 = 10K
            t2 should == t1
        )
        
        it("should create a KelvinTemperature from a decimal value",
            t1 = KelvinTemperature mimic(40.5)
            t2 = 40.5K
            t2 should == t1
        )
        
        it("should create a KelvinTemperature when there's a blank space between value and symbol",
            t1 = KelvinTemperature mimic(10)
            t2 = 10 K
            t2 should == t1
            
            t3 = KelvinTemperature mimic(40.5)
            t4 = 40.5 K
            t4 should == t3
        )
        
        it("should create a KelvinTemperature from a variable",
            ;; for Kelvin is impossible to create the literal from a variable
            ;; without the blank space, because the parser will interpret 
            ;; the whole name as a single identifier (like in v1K)
            v1 = 40
            t1 = v1 K
            t1 should == KelvinTemperature mimic(40)
            
            v2 = 15.5
            t2 = v2 K
            t2 should == KelvinTemperature mimic(15.5)
        )
    )
    
    describe("asText",
        it("should return a text representation of the temperature",
            40ºC asText should == "40ºC"
            40ºF asText should == "40ºF"
            40K asText should == "40K"
        )
    )
    
    describe("+",
        it("should return the sum of two temperatures",
            (2ºC + 40.5ºC) should == 42.5ºC
            (2ºF + 40.5ºF) should == 42.5ºF
            (2K + 40.5K) should == 42.5K
        )
    )
    
    describe("-",
        it("should return the difference of two temperatures",
            (40.5ºC - 10ºC) should == 30.5ºC
            (0ºC - 10ºC) should == -10ºC
            
            (40.5ºF - 10ºF) should == 30.5ºF
            (0ºF - 10ºF) should == -10ºF
            
            (40.5K - 10K) should == 30.5K
            ;; remember: there's no negative Kelvin!
        )
    )
    
    describe("inCelsius",
        it("should return itself for CelsiusTemperature",
            0ºC inCelsius should == 0ºC
        )
        
        it("should convert from FahrenheitTemperature to CelsiusTemperature",
            32ºF inCelsius should == 0ºC
        )
        
        it("should convert from KelvinTemperature to CelsiusTemperature",
            273K inCelsius should == 0ºC
        )
    )
    
    describe("inFahrenheit",
        it("should convert from CelsiusTemperature to FahrenheitTemperature",
            0 ºC inFahrenheit should == 32 ºF
        )
        
        it("should return itself for FahrenheitTemperature",
            0 ºF should == 0 ºF
        )
        
        it("should convert from KelvinTemperature to FahrenheitTemperature",
            273 K inFahrenheit should == 32 ºF
        )
    )
    
    describe("inKelvin",
        it("should convert from CelsiusTemperature to KelvinTemperature",
            0 ºC inKelvin should == 273 K 
        )
        
        it("should convert from FahrenheitTemperature to KelvinTemperature",
            32 ºF inKelvin should == 273 K
        )
        
        it("should return itself for KelvinTemperature",
            273 K inKelvin should == 273 K
        )
    )
)    

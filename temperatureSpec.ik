use("ispec")
use("temperature")

describe("Temperature DSL",
    describe("ºC",
        it("should create a CelsiusTemperature from an integer value",
            CelsiusTemperature mimic(10) should == 10ºC
            CelsiusTemperature mimic(-10) should == -10ºC
        )
        
        it("should create a CelsiusTemperature from a decimal value",
            CelsiusTemperature mimic(40.5) should == 40.5ºC
            CelsiusTemperature mimic(-40.5) should == -40.5ºC
        )
        
        it("should create a CelsiusTemperature when there's a blank space between value and symbol",
            CelsiusTemperature mimic(10) should == 10 ºC
            CelsiusTemperature mimic(-10) should == -10 ºC
            
            CelsiusTemperature mimic(40.5) should == 40.5 ºC
            CelsiusTemperature mimic(-40.5) should == -40.5 ºC
        )
        
        it("should create a CelsiusTemperature from a variable",
            v1 = 40
            v1ºC should == CelsiusTemperature mimic(40)
            -v1ºC should == CelsiusTemperature mimic(-40)
            
            v2 = 15.5
            v2 ºC should == CelsiusTemperature mimic(15.5)
            -v2 ºC should == CelsiusTemperature mimic(-15.5)
        )
    )
    
    describe("ºF",
        it("should create a FahrenheitTemperature from an integer value",
            FahrenheitTemperature mimic(10) should == 10ºF
            FahrenheitTemperature mimic(-10) should == -10ºF
        )
        
        it("should create a FahrenheitTemperature from a decimal value",
            FahrenheitTemperature mimic(40.5) should == 40.5ºF
            FahrenheitTemperature mimic(-40.5) should == -40.5ºF
        )
        
        it("should create a FahrenheitTemperature when there's a blank space between value and symbol",
            FahrenheitTemperature mimic(10) should == 10 ºF
            FahrenheitTemperature mimic(-10) should == -10 ºF
            
            FahrenheitTemperature mimic(40.5) should == 40.5 ºF
            FahrenheitTemperature mimic(-40.5) should == -40.5 ºF
        )
        
        it("should create a FahrenheitTemperature from a variable",
            v1 = 40
            v1ºF should == FahrenheitTemperature mimic(40)
            -v1ºF should == FahrenheitTemperature mimic(-40)
            
            v2 = 15.5
            v2 ºF should == FahrenheitTemperature mimic(15.5)
            -v2 ºF should == FahrenheitTemperature mimic(-15.5)
        )
    )
    
    describe("K",
        it("should create a KelvinTemperature from an integer value",
            KelvinTemperature mimic(10) should == 10K
        )
        
        it("should create a KelvinTemperature from a decimal value",
            KelvinTemperature mimic(40.5) should == 40.5K
        )
        
        it("should create a KelvinTemperature when there's a blank space between value and symbol",
            KelvinTemperature mimic(10) should == 10 K
            KelvinTemperature mimic(40.5) should == 40.5 K
        )
        
        it("should create a KelvinTemperature from a variable",
            ;; for Kelvin is impossible to create the literal from a variable
            ;; without the blank space, because the parser will interpret 
            ;; the whole name as a single identifier (like in v1K)
            
            v1 = 40
            v1 K should == KelvinTemperature mimic(40)
            
            v2 = 15.5
            v2 K should == KelvinTemperature mimic(15.5)
        )
        
        it("should not allow a negative KelvinTemperature",
            fn(KelvinTemperature mimic(-20)) should signal(Condition Error NegativeKelvin)
            fn(KelvinTemperature mimic(20) negation) should signal(Condition Error NegativeKelvin)
            
            fn(-20K) should signal(Condition Error NegativeKelvin)
            fn(-20 K) should signal(Condition Error NegativeKelvin)
            
            fn(20K negation) should signal(Condition Error NegativeKelvin)
            fn(20 K negation) should signal(Condition Error NegativeKelvin)
        )
    )
    
    describe("asText",
        it("should return a text representation of the temperature",
            CelsiusTemperature mimic(40) asText should == "40ºC"
            CelsiusTemperature mimic(-40) asText should == "-40ºC" 
            40ºC asText should == "40ºC"
            40 ºC asText should == "40ºC"
            -40ºC asText should == "-40ºC"
            -40 ºC asText should == "-40ºC"
            
            FahrenheitTemperature mimic(40) asText should == "40ºF"
            FahrenheitTemperature mimic(-40) asText should == "-40ºF" 
            40ºF asText should == "40ºF"
            40 ºF asText should == "40ºF"
            -40ºF asText should == "-40ºF"
            -40 ºF asText should == "-40ºF"
            
            KelvinTemperature mimic(40) asText should == "40K"
            40K asText should == "40K"
            40 K asText should == "40K"
        )
    )
    
    describe("+",
        it("should return the sum of two temperatures of the same unit",
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
            fn(0K - 10K) should signal(Condition Error NegativeKelvin)
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

// Class1.prg
// Created by    : CherylDunn
// Creation Date : 11/19/2025 1:50:00 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text
USING SYSTEM.Globalization

BEGIN NAMESPACE VehicleApp
    
/// STEP 1
/// Vehicle Class with private auto-properties Colour, Make, Model. Includes:
/// 1. constructor to initialise the class
/// 2. display() method to print out the details of the Vehicle
/// </summary>
CLASS Vehicle
    
    // Declare auto-properties
    
    PRIVATE PROPERTY Color AS STRING AUTO
    PRIVATE PROPERTY Make AS STRING AUTO
    PRIVATE PROPERTY Model AS STRING AUTO
    PRIVATE PROPERTY Wheels AS INT AUTO  // Step 10
    PUBLIC PROPERTY Seats AS INT AUTO // Step 13
    PRIVATE STATIC Counter AS INT
    PRIVATE Number  AS INT  //Step 2
        
        
        
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING)
        SELF:Color := color
        SELF:Make := make
        SELF:Model := model
        SELF:Wheels := wheels
        Counter ++
        SELF:Number := Counter
        
    END CONSTRUCTOR
    
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, wheels AS INT)
        SELF:Color := color
        SELF:Make := CapitaliseEachWord(make)
        SELF:Model := CapitaliseEachWord(model)
        SELF:Wheels := wheels
        Counter ++
        SELF:Number := Counter
        
    END CONSTRUCTOR
    
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, wheels AS INT,seats AS INT)
        SELF:Color := color
        SELF:Make := CapitaliseEachWord(make)
        SELF:Model := CapitaliseEachWord(model)
        SELF:Wheels := wheels
        SELF:Seats := seats
        Counter ++
        SELF:Number := Counter
        
    END CONSTRUCTOR
    
    VIRTUAL METHOD DISPLAY() AS VOID
        
        Console.Write( ei"{SELF:GetType():Name} {Number}:\n";
            + ei"\tColor: {Color}\n";
            + ei"\tMake: {Make}\n";
            + ei"\tModel: {Model}\n")
        
    END METHOD
    
    // STEP 10 - Overloaded display class
    VIRTUAL METHOD DISPLAY(includeWheels AS LOGIC) AS VOID
        
        Console.Write( ei"{SELF:GetType():Name} {Number}:\n";
            + ei"\tColor: {Color}\n";
            + ei"\tMake: {Make}\n";
            + ei"\tModel: {Model}\n";
            +IIF(includeWheels,ei"\tWheels: {Wheels}\n","" ))
        
    END METHOD
    
    VIRTUAL METHOD DisplayVroom() AS VOID
        LOCAL type := SELF:GetType():Name
        IF type == "Car"
            Console.WriteLine( "Vroom, vroom")
        ELSEIF type == "Motorbike"
            Console.WriteLine( "Vroooooom")
        ELSEIF type == "Bus"
            Console.WriteLine( "Vroom")
        ENDIF
        
    END METHOD
    
    PUBLIC STATIC METHOD CapitaliseEachWord(SELF s AS STRING) AS STRING
        LOCAL textInfo AS System.Globalization.TextInfo
        textInfo := System.Globalization.CultureInfo.CurrentCulture:TextInfo
        RETURN textInfo:ToTitleCase(s:ToLower())
    END METHOD
    
END CLASS


END NAMESPACE

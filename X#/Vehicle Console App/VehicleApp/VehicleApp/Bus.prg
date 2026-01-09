// Class1.prg
// Created by    : CherylDunn
// Creation Date : 11/20/2025 11:44:10 AM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text

BEGIN NAMESPACE VehicleApp
    
/// <summary>
/// The Class1 class.
/// </summary>
CLASS Bus INHERIT Vehicle
    PRIVATE PROPERTY Floors AS STRING AUTO
    PRIVATE PROPERTY Standing AS INT AUTO
        
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats AS INT, floors AS STRING)
        SUPER(color, make, model, 6, seats)
        SELF:Floors := floors
        SELF:Standing := 0
    END CONSTRUCTOR
    
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats AS INT, floors AS STRING, standing AS INT)
        SUPER(color, make, model, 6, seats)
        SELF:Floors := floors
        SELF:Standing := standing
    END CONSTRUCTOR
    
    OVERRIDE METHOD DISPLAY() AS VOID
        SUPER:DISPLAY()
        Console.Write( ei"\tSeats: {Seats}"+System.Environment.NewLine;
            +ei"\tFloors: {Floors}"+System.Environment.NewLine;
            +ei"\tStanding: {Standing}"+System.Environment.NewLine)
    END METHOD
    
    OVERRIDE METHOD DisplayVroom() AS VOID
        
        Console.WriteLine( "Vroom")
        
    END METHOD
    
END CLASS

END NAMESPACE

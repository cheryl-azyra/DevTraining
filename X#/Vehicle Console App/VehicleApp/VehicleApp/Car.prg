// Class1.prg
// Created by    : CherylDunn
// Creation Date : 11/19/2025 2:46:55 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text
USING System.Linq

BEGIN NAMESPACE VehicleApp
    
    
    
/// STep 3
/// Car class that inherits from Vehicle and has the additional private property Seats.
/// The property should only allow the following values to be assigned to it (1, 2, 4, 5, 7 and 8).
/// Includes:
/// a constructor for the car class which calls the parent constructor.
/// an overload method for the display() method of the parent class.
CLASS Car INHERIT Vehicle
    
    //    // Step 13 -- seats is moved to vehicle
    //     PRIVATE PROPERTY Seats AS AllowedSeats AUTO
    //
    //     CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats as AllowedSeats)
    //         SUPER(color, make, model,seats)
    //         SELF:Seats := seats
    //     END CONSTRUCTOR
    
    // Step 13 -- added seats is moved to vehicle
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats AS AllowedSeats)
        
        TRY
            
            ValidateAllowedSeats(Seats)
            SUPER(color, make, model)
            SELF:Seats := seats
            
        CATCH e AS Exception
            
            console.WriteLine(ei"Error! {e:Message}")
            
        END TRY
        
    END CONSTRUCTOR
    
    
    OVERRIDE METHOD DISPLAY() AS VOID
        SUPER:DISPLAY()
        Console.Write( ei"\tSeats: {Seats}"+System.Environment.NewLine )
    END METHOD
    
    PUBLIC STATIC METHOD ValidateAllowedSeats(seats AS INT) AS VOID
        
        TRY
            
            LOCAL aSeatsAllowed AS INT[]
            aSeatsAllowed := <INT>{1, 2, 4, 5, 7, 8}
            
            IF !aSeatsAllowed:Contains(Seats)
                
                THROW Exception{ei"{seats} is an invalid Number of Seats! Must be within (1, 2, 4, 5, 7 and 8). "}
                
            ENDIF
            
        CATCH e AS Exception
            
            THROW e
            
        END TRY
        
    END METHOD
    
END CLASS

END NAMESPACE

//// Step 13 -- seats is moved to vehicle
ENUM AllowedSeats AS INT
    One := 1
    Two := 2
    Four := 4
    Five := 5
    Seven := 7
    Eight := 8
END ENUM

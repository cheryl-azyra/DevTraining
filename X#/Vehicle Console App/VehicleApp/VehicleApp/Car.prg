// Class1.prg
// Created by    : CherylDunn
// Creation Date : 11/19/2025 2:46:55 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text

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
//         This:Seats := seats
//     END CONSTRUCTOR

  // Step 13 -- added seats is moved to vehicle
    CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats AS AllowedSeats)
        SUPER(color, make, model)
        This:Seats := seats
    END CONSTRUCTOR


    OVERRIDE METHOD DISPLAY() AS VOID
        Super:DISPLAY()
        Console.Write( ei"\tSeats: {Seats}\n" )
    END METHOD

	END CLASS

END NAMESPACE // VehicleApp

//    // Step 13 -- seats is moved to vehicle
ENUM AllowedSeats AS INT
        One := 1
        Two := 2
        Four := 4
        Five := 5
        Seven := 7
        Eight := 8
END ENUM

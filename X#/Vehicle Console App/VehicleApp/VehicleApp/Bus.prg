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
	PRIVATE PROPERTY Floors AS String AUTO
	PRIVATE PROPERTY Standing AS INT AUTO


	CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING, seats as INT, floors AS STRING, standing AS INT )
		SUPER(color, make, model,6, seats)
		THIS:Floors := floors
		THIS:Standing := standing
	END CONSTRUCTOR

   OVERRIDE METHOD DISPLAY() AS VOID
		Super:DISPLAY()
		Console.Writes( ei"\tSeats: {Seats}\n";
							+ei"\tFloors: {Floors}\n";
							+ei"\tStanding: {Standing}\n")
	END METHOD


	END CLASS

END NAMESPACE

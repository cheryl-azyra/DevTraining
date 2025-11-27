// Class1.prg
// Created by    : CherylDunn
// Creation Date : 11/20/2025 8:49:10 AM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55


USING System
USING System.Collections.Generic
USING System.Text

BEGIN NAMESPACE VehicleApp

	/// <summary>
    /// The Class1 class.
    /// </summary>
	CLASS Motorbike INHERIT Vehicle

       CONSTRUCTOR(color AS STRING, make AS STRING, model AS STRING)
            SUPER(color, make, model,2)
       END CONSTRUCTOR

	END CLASS
END NAMESPACE // VehicleApp

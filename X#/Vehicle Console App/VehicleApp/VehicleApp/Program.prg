// Program.prg
// Created by    : CherylDunn
// Creation Date : 11/19/2025 1:49:41 PM
// Created for   :
// WorkStation   : LAPTOP-U2T07M55

USING System
USING System.Collections.Generic
USING System.Linq
USING System.Text
USING VehicleApp

FUNCTION Start() AS VOID STRICT
    Console.WriteLine("WELCOME TO THE VEHICLE APP!")
    
    // 	//// Steps 1 and 2
    // 	//     LOCAL v1 AS Vehicle
    // 	//     LOCAL v2 AS Vehicle
    // 	//
    // 	//     v1 := Vehicle{"Red", "Ford", "F150"}
    // 	//     v2 := Vehicle{"Black", "Dodge", "Grand Caravan"}
    // 	//
    // 	//
    // 	//     // Print Vehicle Detail
    // 	//     Console.WriteLine(e"-----------------------------------------"+System.Environment.NewLine;
    // 	//                         +e"Testing Vehicles (from steps  1 and 2)"+System.Environment.NewLine)
    // 	//     v1:Display()
    // 	//     v2:Display()
    // 	//
    
    //    STEP 4)	Create the following cars and add them to a List<Car>
    //
    //     a.	Black, Volkswagon Golf, 5 seats
    //     b.	Red, Ford Mustang, 4 seats
    //     c.	Mazda MX-5, 2 seats
    //     d.	Kia Sorento, 7 seats
    
    
    LOCAL carsList AS List<Car>
    LOCAL carsCXArr AS Car[]
    LOCAL carsXArr AS ARRAY
    LOCAL c1 AS Car
    LOCAL c2 AS Car
    LOCAL c3 AS Car
    LOCAL c4 AS Car
    LOCAL c5 AS Car
    
    // Create cars
    c1 := Car{"Black", "Volkswagon", "Golf", AllowedSeats.Five}
    c2 := Car{"Red", "Honda", "Civic", AllowedSeats.Four}
    c3 := Car{"", "Mazda", "MX-5", AllowedSeats.Two}
    c4 := Car{"", "Kia", "Sorento", AllowedSeats.Seven}
    
    // Testing error prints if creating a car with invalid number of seats
    PrintStep("3")
    Console.WriteLine(e"Testing error prints if creating a car with 3 seats "+System.Environment.NewLine)
    c5 := Car{"", "Kia", "Sorento", (AllowedSeats)3}
    
    // Add to Cars list
    carsList := List<Car>{}
    carsList:Add(c1)
    carsList:Add(c2)
    carsList:Add(c3)
    carsList:Add(c4)
    
    
    // Add to C# Array in X#
    
    carsCXArr := <Car>{c1, c2, c3, c4}
    
    // STEP 5)	Create an empty X# array and then add the first and third cars in the List<Car> to it. Print out the details of the second car in the X# array.
    // add to X# Array
    carsXArr :=  { (Car)carsList[0], (Car)carsList[2] }
    
    // STEP 6)	Use two separate For loops to display the details of the cars created in 4) and 5)
    PrintStep("6")
    Console.WriteLine(e"Testing: Print Step 4 list using For loop : should have 1,2,3,4 cars "+System.Environment.NewLine)
    PrintListCar(carsList)
    
    Console.WriteLine(e"\nTesting: Print Step 4 C# array in X# using ForEach loop : should have 1,2,3,4 cars "+System.Environment.NewLine)
    PrintCXCarArray(carsCXArr)
    
    Console.WriteLine(e"\nTesting: Print step 5 X# array using For loop : should have cars 1 and 3"+System.Environment.NewLine)
    PrintXArray(carsXArr)
    
    // STEP 7)	Create a List and add the second and fourth cars from the C# array to it. Add this list to the end of the X# array.
    PrintStep("7")
    LOCAL carsList2 AS List<Car>
    LOCAL cb AS CODEBLOCK
    cb := {|v AS Vehicle| v:GetType():Name:toLower() != "vehicle"  }
    
    // Created list with 2nd and 4th car from C# array: should have car 2 and 4
    carsList2 := List<Car>{}
    carsList2:Add(carsCXArr[2]) // 2nd car
    carsList2:Add(carsCXArr[4]) // 4th car
    
    FOREACH c AS Car IN carsList2
        AAdd(carsXArr,c)
    NEXT
    
    Console.WriteLine(e"Testing: 7)	Create a List and add the second and fourth cars from the C# array to it. Add this list to the end of the X# array: should have cars 1,3,2,4  "+System.Environment.NewLine)
    PrintXArray(carsXArr)
    
    // STEP 8) Create a Codeblock to test if an object is not of type Vehicle. Use this Codeblock to determine which element in the X# array is not a Vehicle and print it out.
    PrintStep("8")
    LOCAL Pos AS DWORD
    Pos := ASCAN(carsXArr,cb)
    
    Console.WriteLine(ei"Testing: Printing which element in X# Array is not a vehicle & printing it: will return position 1 and print car 1"+System.Environment.NewLine)
    
    Console.WriteLine(i"The object at position {Pos} is not a Vehicle")
    ((Vehicle)carsXArr[Pos]):DISPLAY()
    
    // Step 9)	Use System.Linq.IEnumerable<T>.OrderBy and a lambda expression to sort the cars by number of seats in descending order.
    PrintStep("9")
    Console.WriteLine(e"Testing: Print carsList Pre Sort by seat descending"+System.Environment.NewLine)
    PrintListCar(carsList)
    carsList := carsList:OrderByDescending({c => c:Seats}):toList()
    
    Console.WriteLine(e"\nTesting:  Print carsList After Sort by seat descending"+System.Environment.NewLine)
    PrintListCar(carsList)
    
    
    // STEP 11) Create the following motorbikes and add them to the C# and X# arrays from 4) and 5) – handle any errors with a try-catch block
    // a.	Red, Honda 50
    // b.	Blue, Yamaha R1
    PrintStep("11")
    TRY
        LOCAL m1 AS Motorbike
        LOCAL m2 AS Motorbike
        m1 := Motorbike{"Red", "Honda", "50"}
        m2 := Motorbike{"Blue", "Yamaha", "R1"}
        
        // Add to List from step 4)
        // carsList:Add(m1)
        // carsList:Add(m2)
        
        // Add to C# in X# Array from step 4)
        AAdd(carsCXArr, m1)
        AAdd(carsCXArr, m2)
        
        Console.WriteLine(e"Testing: printing C# Array in X# - after trying to add motorbikes : should have cars 1,2,3,4 "+System.Environment.NewLine)
        PrintCXCarArray(carsCXArr)
        
        // Add to X# Array from step 5)
        AAdd(carsXArr, m1)
        AAdd(carsXArr, m2)
        
        Console.WriteLine(e"\nTesting: Updated X# Array  - after trying to add motorbikes : should have print cars  1,3,2,4 and motorbikes 5, 6 "+System.Environment.NewLine)
        PrintXArray(carsXArr)
        
    CATCH e AS Exception
        
        Console.WriteLine(ei"ERROR occured during processing of Step 11 : {e:Message}"+System.Environment.NewLine);
            
    END TRY
    Console.WriteLine(ei"QUESTION RESPONSE: \n\t you cannot buld if you add motorbikes to a cars list. \n\t You cannot add motorbikes to cars C# array in X# - the system does not error and they are not added. \n\t You can add motorbikes to X#  cars arrays - but they will error when you try to access motorbikes as cars"+System.Environment.NewLine);
        
    // 12)	Use a foreach loop to loop through the X# array from 5) and only display the details of the Motorbikes
    PrintStep("12")
    LOCAL cb2 AS CODEBLOCK
    cb2 := {|v AS Vehicle| v:GetType():Name:ToLower() == "motorbike" }
    
    Console.WriteLine(e"Testing: Print each motorbike in X# array : should print motobikes 5, 6"+System.Environment.NewLine)
    
    FOREACH v AS Vehicle IN carsXArr
        IF eval(cb2, v)
            v:Display(TRUE)
        ENDIF
    NEXT
    
    //14)	Create the following busses and add them to the X# array from 5)
    // a.	Grey, Volvo 9900, single floor, 60 seats
    // b.	Volvo B5TL, 2 floors, 80 seats, 50, standing
    // c.	WrightBus Eclipse Gemini, double deck, 76 seats, 52 standing
    PrintStep("14")
    
    LOCAL b1 AS Bus
    LOCAL b2 AS Bus
    LOCAL b3 AS Bus
    b1 :=   Bus{"Grey", "Volvo", "9900", 60, "single floor", 0}
    b2 :=   Bus{"", "Volvo", "B5TL", 80, "2 floors", 50 }
    b3 :=	Bus{"", "WrightBus ", "Eclipse Gemini", 76, "double deck",52}
    
    Console.WriteLine(e"Testing: Created 3 buses")
    
    b1:DISPLAY()
    b2:DISPLAY()
    b3:DISPLAY()
    
    AAdd(carsXArr,b1)
    AAdd(carsXArr,b2)
    AAdd(carsXArr,b3)
    
    Console.WriteLine(e"Testing: Update X# Array with added buses : should print car 1,3,2,4, motorbike 5, 6, bus 7 , 8, 9")
    
    PrintXArray(carsXArr)
    
    //	15)	Use a foreach loop and a do-case statement to loop through the X# array and display the following
    
    // a.	If the object in the array is a Car, print “Vroom, vroom”.
    // b.	If the object is a motorbike, print “Vroooooom”.
    // c.	If the object is a bus, print “Vroom”
    PrintStep("15")
    
    Console.WriteLine(e"Testing: Print each vehicle with Vroom Variant in X# array")
    
    
    FOREACH v AS Vehicle IN carsXArr
        v:DisplayVroom()
    NEXT
    
    //16)	Write a string extension method to capitalise the first letter of every word. Enhance the Make and Model properties in the vehicle class to capitalise the first letter of every word by using the extension method
    PrintStep("16")
    
    LOCAL b4 AS Bus
    b4 := Bus{"", "make test ", "model test", 76, "double deck",52}
    
    Console.WriteLine(e"Testing: Print a bus which is created using CapitaiseEachWork values are: 'make test', 'model test'")
    
    b4:DISPLAY()
    
    Console.WriteLine(e"\nPress any key to continue...")
    Console.ReadKey()
    
    RETURN
    
FUNCTION PrintStep(currStep AS STRING) AS VOID
    Console.WriteLine(e"-----------------------------------------"+System.Environment.NewLine;
        +i"Step {currStep}")
END FUNCTION

FUNCTION PrintListCar(carsList AS List<Car>) AS VOID
    LOCAL i AS INT
    FOR i := 0 TO carsList:Count-1
        carsList[i]:Display()
    NEXT
    
END FUNCTION

FUNCTION PrintCXCarArray(carsCXArr AS Car[]) AS VOID
    
    FOREACH c AS Car IN carsCXArr
        c:Display()
    NEXT
    
END FUNCTION

FUNCTION PrintXArray(XArr AS ARRAY) AS VOID
    LOCAL i AS INT
    FOR i := 1 TO XArr:Count
        LOCAL currVehicle AS Vehicle
        currVehicle := (Vehicle) XArr[i]
        IF currVehicle:GetType():Name:ToLower()  == "car"
            ((Car) XArr[i]):Display()
        ELSEIF currVehicle:GetType():Name:ToLower()  == "motorbike"
            ((Motorbike) XArr[i]):Display()
        ELSEIF currVehicle:GetType():Name:ToLower()  == "bus"
            ((Bus) XArr[i]):Display()
        ELSE
            Console.writeLine(ei"ERROR: Invalid Type - cannot print element at position {i}"+System.Environment.NewLine)
        ENDIF
    NEXT
    
END FUNCTION

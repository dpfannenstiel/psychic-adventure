/*:
# Protocol-Oriented Programming
## A Flat World Primer

Protocol-Oriented Programming is baked in throughout Swift 2.0.
Many Swift Standard Library functions & structs utilize POP to promote utility, extensibility, and testing.
By utilizing POP the developer can mitigate problems inherent to classes such as pointer sharing, inheritence, and type saftey.
The last of which becomes important in Swift due it's native static runtime.

This tutorial document will illustrate:
* [Defining a Protocol](Defining%20a%20Protocol)
* [Extending a Protocol](Extending%20a%20Protocol)
* [Constrained Extension(Conditional%20Extension)
*/

import UIKit

/*:
Before we begin consider the rather prosaic example of attempting to define vehicles as a class.
*/

/// Any object capable of locomotion.
class IntroductionVehicle {
    /// The speed at which the vehicle is traveling.  Defaults to zero.
    var speed:Double = 0.0
}

/// A two wheeled vehicle capable of supporting one or more passengers, with a minimum of one to provide locomotion.  This vehicle performs exclusivly on land.
class Bicycle:IntroductionVehicle{
    /// Number of wheels.
    let wheels:Int = 2
}

/// A vehicle with 4 or more wheels capable of supporting zero or more passengers.  I'm not saying you should get out of the car while in gear, I am saying that doing so may cause it to run into the house thereby getting you grounded for a month.  Or so I hear. This vehicle performs exclusivly on land.
class Car:IntroductionVehicle {
    /// Number of wheels.
    var wheels:Int = 4
}

/// A vehicle which performs exclusively on water.  It has no wheels and is capable of supporting zero or more passengers.  See the above note about not leaving it while it is running.
class Boat:IntroductionVehicle {
    /// Number of wheels.
}

/// The medium on which the vehicle is traveling.
enum OperationalMedium {
    /// Vehicle is on the land.
    case Land
    /// Vehicle is in the air.
    case Air
}

/// A vehicle with at least 3 wheels which performs either on the ground or in the air.  It is capable of supporting zero or more passengers.  Again, if you're the last person in an operating plane, don't get out.
class Plane:IntroductionVehicle {
    /// Number of wheels.
    let wheels:Int = 16 // Yes, it's a 747.
    /// Medium in which the vehicle is traveling.
    var operationalState:OperationalMedium = .Land
}

let bicycle = Bicycle()
let car = Car()
let boat = Boat()
let plane = Plane()

/*:
In the above example, each vehicle is provided with only the information required by the object description.  Attempts to deal with collections of these items would require defining a collection, in this case an array, of their common superclass, `IntroductionVehicle`.
*/

let vehicles:[IntroductionVehicle] = [bicycle, car, boat, plane]

/*:
Attempts to maniuplate individual objects in the collection now becomes difficult as we have to optionally downcast objects to perform operations.  As Dave Abrahams said `as! ASubclass` should be treated as a code smell.
*/

let bicycles = vehicles.filter() { ($0 as? Bicycle) != nil }
// Mayber you're wondering why I'm not using wheels?  Because wheels are members of the class, not the protocol.
/*:
When stepping into the following loop the compiler only sees `bicycle` as an array of `IntroductionVehicle`s.  This can become scary fast.
*/
for bike in bicycles {
    
    let localBike = bike as! Bicycle
    print(localBike.wheels)
    
}



//: [Next](@next)


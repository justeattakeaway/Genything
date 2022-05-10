import Foundation
import Genything
import GenythingTest
import Trickery
import XCTest

/*:
# Composing With Operators Introduction
 
With Genything, we can generate any randon value for each type, for example:
 
*/
 
let integer = Int.arbitrary.next(.random())
let double = Double.arbitrary.next(.random())
let string = String.arbitrary.next(.random())
let character = Character.arbitrary.next(.random())

/*: Including Optionals */

let integerOptional = Int?.arbitrary.next(.random())

/*: And even more complex types, like: */

let integerArray: [Int] = Array.arbitrary.next(.random())
let integerOptionalArray: [Int?] = Array.arbitrary.next(.random())
let dictionary: Dictionary<Int, String> = Dictionary.arbitrary.next(.random())

/*:
# Operators Examples
 ## Expand
 While working with arrays, the lib allows to create an array with a fixed size
*/

let fixedSizeArray = Int.arbitrary.expand(toSize: 2).next(.random())

/*: or with the size inside a range */

let rangeSizedArray = Int.arbitrary.expand(toSizeInRange: 0...5).next(.random())

/*:
 ## Weighted
This method allows to attribute weight to each element to be generated. For this example, this would generate twice as many apples as bananas. The size was setted randomly to show the example
 */

let weighted = Generators
    .weighted([
        (2, "Apple"),
        (1, "Banana"),
    ])
    .expand(toSize: 6)
    .next(.random())

/*:
 ## Loop
The loop method would create an array of a random size containing a loop of the previously setted values. For this example, the size was setted in order to show the expected result
 */

let loop = Generators
    .loop(0...3)
    .expand(toSize: 10)
    .next(.random())

/*:
 # Mutating Operators.
 Moving forward, the lib allows to mutate the data using some Rx programming, as:
 
 ## Map
 
 Map returns an object with the results of mapping the given closure over the previous elements
 */

let mapCountValue = Generators
    .constant(32) // starts at 32
    .map { $0 + 1 }
    .map { $0 + 1 }
    .map { $0 + 1 } // add 3
    .next(.random())

/*:
Map returns an array containing the results of mapping the given closure over sequence. In this case, the array of characters would be transformed into a String
*/


let mapCharToString = Character.arbitrary
    .expand(toSizeInRange: 1 ... 5)
    .map { (chars: [Character]) -> String in String(chars) }
    .next(.random())
/*:
## FlatMap
 Flat map would flaten up the result of the map, and it would turn the received value into a Generator
 */

let arrayOfGenerators: [AnyGenerator<Int>] = [
    (0..<5).arbitrary,
    (6...10).arbitrary
]

let generatorOfRandomGenerators: AnyGenerator<AnyGenerator<Int>> = arrayOfGenerators.arbitrary

generatorOfRandomGenerators.next(.random()).next(.random())

let flattenArray = generatorOfRandomGenerators.flatMap { $0 }.next(.random())

/*:
## Zip.
When you zip two Generators, it returns a single Generator with an array of the two elements zipped. Here is a demonstration that the zip return is correct.
*/
let a = Int.arbitrary.expand(toSize: 1)
let b = Int.arbitrary.expand(toSize: 2)

let result = Generators.zip(a, b)
    .map {  $0.0.count == 1 && $0.1.count == 2 }
    .next(.random())


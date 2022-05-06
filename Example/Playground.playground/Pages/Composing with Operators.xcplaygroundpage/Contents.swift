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
 ## Seed Value
But that is not just it... With genything, we can manipulate the data so it fulfill any expecatations.
For example, we can influence the randon with a specific seed value
 */

let seedValue = Int.arbitrary.next(.predetermined(seed: 5))


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
## CompactMap
 Compact map would not return nil value on the array, returning an array of non-optionals
 */

let removeNilFromIntArray = Array<Int?>
    .arbitrary
    .next(.random())
    .compactMap { $0 }

/*:
## FlatMap
 Flat map would flatetn up the array, and turn the array of arrays into only one sequence
 */

let flatTwoArrays = Array<Int>
    .arbitrary
    .expand(toSize: 3) // This would return an Array of Array<Int>
    .next(.random())
    .flatMap { $0 }

/*:
## Reduce
 This operator goes through the array and do a specific defined operation. In this case, reduce will sum the integer values
 */

let totalSum = Int
    .arbitrary
    .expand(toSizeInRange: 0...5).next(.random())
    .reduce(0, +)
/*:
## Zip.
When you zip two Generators, it returns a single Generator with an array of the two elements zipped. Here is a demonstration that the zip return is correct
*/
let a = Int.arbitrary.expand(toSize: 1)
let b = Int.arbitrary.expand(toSize: 2)

let result = Generators.zip(a, b)
    .map {  $0.0.count == 1 && $0.1.count == 2 }
    .next(.random())


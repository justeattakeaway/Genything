<p align="center">
<img src="https://raw.githubusercontent.com/justeattakeaway/Genything/main/assets/Genything-icon.png" width="35%" alt="Genything" /><br/>
</p>

<h1 align="center">Genything</h1>

<p align="center">
<a href="#">
<img src="https://img.shields.io/badge/Swift-5.0+-FE8001?style=flat-square"
    alt="Swift: 5.0">
</a>
<a href="#">
<img src="https://img.shields.io/badge/Platforms-iOS%20|%20tvOS%20|%20watchOS%20|%20macOS-FE8001.svg"
    alt="Platforms: iOS – tvOS – watchOS – macOS">
</a>
<a href="https://cocoapods.org/pods/Genything">
<img src="https://img.shields.io/cocoapods/v/Genything.svg"
    alt="Cocoapods Compatible">
</a>
<a href="#">
<img src="https://img.shields.io/badge/Swift_Package_Manager-Compatible-FE8001?style=flat-square"
    alt="Swift Package Manager Compatible">
</a>
</p>

## Genything - Generate Anything

Genything is a library dedicated to easy and composable generation of random data, no matter how complex.

Genything can be combined with [Trickery](#Trickery) which provides a growing library of pre-made generators which mock real-world information.

Both of these libraries may be used for code testing, rapid prototyping, demo applications, ui testing, and much more. Be creative!

- [Why use Genything?](#why-use-genything-)
  * [Gen](#gen)
  * [Arbitrary](#arbitrary)
- [Trickery](#trickery)
- [Examples](#examples)
- [Mixins](#mixins)
- [Installation](#installation)
  * [Cocoapods](#cocoapods)
  * [Swift Package Manager](#swift-package-manager)
- [Credits](#credits)
  * [Contributing](#contributing)
  * [Inspiration](#inspiration)
- [[License](./LICENSE)](#-license---license-)

## Why use Genything?
  
- We do not include a dependency on XCTest
- Controllable randomness that's deterministic by default
  - Produce the same results on CI, your colleagues machine, and your own
- You can use these generators for anything!
  - Create dummy data for your example apps or to rapidly prototype features
  - Use them in your SwiftUI previews to rapidly discover edge cases
  - Run your [screenshot](https://github.com/pointfreeco/swift-snapshot-testing) [tests](https://github.com/uber/ios-snapshot-test-case) with easy-to-use and predictable data
  - Use your generators to unit test with [Property Based Testing](https://medium.com/criteo-engineering/introduction-to-property-based-testing-f5236229d237)
- High test coverage
- [100% Documented](https://justeattakeaway.github.io/Genything)

### Gen

The `Gen` type class is the core of Genything.
It is nothing more than a generic container that stores a callback capable of generating a value from a `Context`.

```swift
struct Gen<T> {
    let generator: (Context) throws -> T
}
```

The `Context` contains configuration, and a Random Number Generator which you can customize.

So a generator of Booleans might look like this:

```swift
Gen<Bool> { context in
    Bool.random(using: &context.rng)
}
```

This is a good to understand, but in practice you can avoid `Gen`'s initializer altogether and instead use the vast library of extensions to build, combine, and mutate `Gen`s.

You can find out more about these extensions in the [documentation](https://justeattakeaway.github.io/Genything/Structs/Gen.html)!

### Arbitrary

The `Arbitary` protocol allows a Type to define a generator suitable for generating **all** of it's values.

Take Swift's `Bool` as example, it's Arbitrary is defined as:

```swift
extension Bool: Arbitrary {
    public static var arbitrary: Gen<Bool> {
        Gen.of([true, false])
    }
}
```

We can now use this definition automatically when we are composing a more complex arbitrary type:

```swift
struct Transaction {
  let isComplete: Bool
  // ...
}

extension Transaction: Arbitrary {
    public static var arbitrary: Gen<Bool> {
        Gen.compose {
          Transaction(
            isComplete: $0.generate(), // Will equally generate True or False when the Transaction generator is run
            //...
          )
        }
    }
}
```

These can then be used for invariant tests, to stub an API response, as preview data, etc...
  
## Trickery
  
Genything comes together with Trickery, a collection of generators suitable for producing pseudo-realistic data according to real-world-conditions rather than those enforced only by the type.

Consider a phone number. A phone number of type `String` has rules about length, formatting, allowable characters. Whereas the arbitrary type `String` contains contains at most a definition of it's length

## GenythingTest

A key consideration for Genything is that your Generators be usable Genywhere (anywhere). In order to help enforce that  

## Examples

### Examples: Gen

#### Using Genything to create a dice roller

```swift

// A very basic dice roll example
let d4 = Gen<Int>.from(1...4)
print("d4: \(twoD4Plus2.sample())")

// Getting more complex with an RPG-style multiple dice roll
func diceRoller(_ dice: [Gen<Int>], modifier: Int = 0) -> Gen<Int> {
    Gen.reduce(dice, modifier, +)
}

// Roll 2 d4s with a +2 modifier
let twoD4Plus2 = diceRoller([d4, d4], modifier: 2)
print("2d4+2: \(twoD4Plus2.sample())")
```

#### Using Genything to produce random city names from a list

```swift
import Genything

let cityGen = Gen.of(["Winnipeg","Calgary","Vancouver","Halifax"])

/// Generates 1 city
cityGen.generate()

/// Takes 100 random cities
cityGen.take(count: 100)

/// Prints values from the generator until the Context's max iterations is reached
cityGen.forEach { city in print(city) }

```

### Examples: Arbitrary

#### Using Arbitrary to sanity check an invariant condition

```swift
checkAll(UInt.arbitrary) { number in
    XCTAssert(divideByTwo(Int(number)) < number)
}
```

### Examples: Trickery

#### Using fake data to render a Swift UI preview

```swift
import Trickery

struct PhoneBook_Previews: PreviewProvider {
    static var previews: some View {
        PhoneBook(
          Gen.zip(
            Fake.PersonNames.full, 
            Fake.PhoneNumbers.formatted
          ) { 
            PhoneBookRow(name: $0, number: $1) 
          }.take(count: 10)
        )
    }
}

```

## Mixins

Genything & Trickery are also amazing when combined with other open source libraries!

### [SFSafeSymbols](https://github.com/piknotech/SFSafeSymbols)

Generate any [SF Symbol](https://developer.apple.com/sf-symbols/)

```swift
extension Fake {
    public enum SFSafeSymbols {
        @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
        public static let any: Gen<SFSymbol> = .ofCases().map { $0.rawValue }
    }
}
```

## Installation

### Cocoapods

```ruby
pod 'Genything'
pod 'Trickery' # Optional library of realistic fake data
pod 'GenythingTest' # Optional extensions for property test assertions
```

### Swift Package Manager

Create a `Package.swift` file in your root directory and add:

```swift
dependencies: [
    .package(url: "https://github.com/justeattakeaway/genything.git", .exact("0.0.1"))
]
```

Then add the packages you want to:

- General -> "Frameworks and Libraries", for an application of framework target
- Build Phases -> "Link Binary With Libraries", for a test target

## Credits

The Genything and Trickery projects are owned and maintained by [SkipTheDishes](https://www.skipthedishes.com/), a [Just Eat Takeaway.com](https://www.justeattakeaway.com/) subsidiary.

### Contributing

Please read the [Contribution Guide](./CONTRIBUTING.md)

### Inspiration

Genything stands on the shoulder of giants. Please check out these other libraries and resources!
  
- [SwiftCheck](https://github.com/typelift/SwiftCheck)
- [Fakery](https://github.com/vadymmarkov/Fakery)
- [Point-Free](https://www.pointfree.co/)'s lessons on [predictable randomness](https://github.com/pointfreeco/episode-code-samples/tree/main/0048-predictable-randomness-pt2)
- [Kotest](https://kotest.io/)'s [Property Based Testing](https://kotest.io/docs/proptest/property-based-testing.html)

## [License](./LICENSE)

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/

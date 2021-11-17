<p align="center">
<img src="assets/Genything-icon.png" width="35%" alt="Genything" /><br/>
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

## Generate Anything

Genything is a framework for random testing of a program properties. It provides way to random data based on simple and complex types.

Combined with [Trickery](#Trickery) it allows the generation of data according to real world scenarios, which can be used for code testing, demo applications, ui testing, usability tests, be creative!

## About
  
  An opinionated distillation of the successful patterns from QuickCheck, SwiftCheck, and Kotest.
  Directed towards testing of a product rather than library.
  
**Why use Genything?**
  
- We do not depend on XCTest
- Predictable randomness is expected
- We are agnostic to how the generators are used
  - Testing scenarios that require pseudo-random data
  - Realistic models for previewing content and detecting UI issues

### Arbitrary Types
  
Arbitrary types provide a pseudo-random generator suitable for checking the hypothetical correctness of code without strict definition of all cases. It's used for [property testing](https://medium.com/criteo-engineering/introduction-to-property-based-testing-f5236229d237).
  
## Trickery
  
Genything comes together with Trickery, a collection of generators suitable for producing pseudo-realistic data according to real-world-conditions rather than those enforced only by the type.

Consider a phone number. A phone number of type `String` has rules about length, formatting, allowable characters. Whereas the arbitrary type `String` contains contains at most a definition of it's length
  
## Features

### Genything

- [Linear Congruential Generator](https://en.wikipedia.org/wiki/Linear_congruential_generat)
- Arbitrary of: Bool, Double, Int, UInt, Int32, UInt32, UnicodeScalar, Character, String, Array, Optional, AnySequence, AnyBidirectionalCollection, ArraySlice, Dictionary, CGFloat, UUID, Core Location
 
### Trickery

- Fake of: Characters, ID, Locattion, Lorem, Numerics, Web, Person, Address, Telephone
- Can create fake from json using Codable

## Usage

### Genything/Gen

Will print one of the cities from the generator

```swift
import Genything

let genCities = Gen.of(["Winnipeg","Calgary","Vancouver","Halifax"])
debugPrint(genCities.sample())
```

### Genything/Arbitrary

Will print an arbitrary string with any number of random characters

```swift
import Genything
 
let arbitraryString = String.arbitrary.sample()
debugPring(arbitraryString)
```

### Trickery/Fake

Will print a random alphanumeric character

```swift
import Trickery

let fakeAlphanumericCharacters = Fake.Characters.alphanumeric.sample()
debugPrint(fakeAlphanumericCharacters)
```

## Installation

### Cocoapods

```ruby
pod 'Genything'
pod 'Trickery'
```

### Swift Package Manager

Create a `Package.swift` file in your root directory and add:

```swift
dependencies: [
    .package(url: "https://github.com/justeattakeaway/genything.git", .exact("0.0.1"))
]
```

## Credits

The Genything and Trickery projects are owned and maintained by [SkipTheDishes](https://www.skipthedishes.com/), a [Just Eat Takeaway](https://www.justeattakeaway.com/) subsidiary.

### Contributing
Please read the [Contribution Guide](./CONTRIBUTING.md)

### Inspiration
  
- https://github.com/typelift/SwiftCheck
- https://github.com/pointfreeco/episode-code-samples/tree/main/0048-predictable-randomness-pt2
- https://github.com/kotest/kotest/tree/master/kotest-property/src/commonMain/kotlin/io/kotest/property
- https://hackage.haskell.org/package/QuickCheck

## [License](./LICENSE)

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/

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
- [License](./LICENSE)

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
- [100% Documented](https://justeattakeaway.github.io/Genything/documentation/genything/)

### Generator

The `Generator` is the core of Genything.

```swift
public protocol Generator {
    associatedtype T
    func next(_ randomSource: RandomSource) -> T
}
```

It defines a type with a function capable of generating values using a `RandomSource`.
The `RandomSource` is used to track and mutate any RandomNumberGenerator instance, allowing you to control just how **much** random you would like.

A generator of bools might look like this:

```swift
struct BoolGenerator: Generator {
    func next(_ randomSource: RandomSource) -> T {
        Bool.random(using: &randomSource.rng)
    }
}
```

or

```swift
AnyGenerator<Bool> { randomSource in
    Bool.random(using: &randomSource.rng)
}
```

Or, we can take advantage of Genything's arbitrary conformance for most standard Swift types (including `Bool`)

```swift
Bool.arbitrary
```

Genything provides numerous ways to [create your own Generators](https://justeattakeaway.github.io/Genything/documentation/genything/generators) under the `Generators` namespace, and the `Generator` type is [extended by many operators](https://justeattakeaway.github.io/Genything/documentation/genything/generator) which you can use to further mutate and control the resulting generator.

### Arbitrary

The `Arbitary` protocol allows a Type to define a generator suitable for generating **all** of it's values.

Take Swift's `Bool` as example, it's Arbitrary is defined as:

```swift
extension Bool: Arbitrary {
    public static var arbitrary: AnyGenerator<Bool> {
        [true, false].arbitrary
    }
}
```

We can now use this definition automatically when we are composing a more complex arbitrary type:

```swift
struct Foo {
  let bar: Bool
  // ...
}

extension Transaction: Arbitrary {
    public static var arbitrary: AnyGenerator<Bool> {
        Gen.compose { generate in
          Foo(
            bar: generate(), // Will return true/false like a coin-flip for each generated value
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

Genything provides two extensions for `XCTestCase` which we suggest that you use as your primary method for property testing.

- `testAll(generator:config:file:line:body)`
- `testAllSatisfy(generator:config:file:line:predicate)`

## Examples

Checkout out our [Playground guide](Example/Playground.playground)

## Mixins

Genything is happy when combined with other open source libraries!

### Generate arbitrary SFSymbols with [SFSafeSymbols](https://github.com/piknotech/SFSafeSymbols)

Generate any [SF Symbol](https://developer.apple.com/sf-symbols/)

```swift
import SFSafeSymbols

let sfSymbolGen: AnyGenerator<SFSymbol> = SFSymbol.arbitrary.map { $0.rawValue }
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

The Genything project is owned and maintained by [SkipTheDishes](https://www.skipthedishes.com/), a [Just Eat Takeaway.com](https://www.justeattakeaway.com/) subsidiary.

### Contributing

Please read the [Contribution Guide](./CONTRIBUTING.md)

### Inspiration

Genything stands on the shoulder of giants. Please check out these other libraries and resources!
  
- [SwiftCheck](https://github.com/typelift/SwiftCheck)
- [Fakery](https://github.com/vadymmarkov/Fakery)
- [Point-Free](https://www.pointfree.co/)'s lessons on [predictable randomness](https://github.com/pointfreeco/episode-code-samples/tree/main/0048-predictable-randomness-pt2)
- [Kotest](https://kotest.io/)'s [Property Based Testing](https://kotest.io/docs/proptest/property-based-testing.html)

## License

See: [License](./LICENSE)

Apache License Version 2.0, January 2004 http://www.apache.org/licenses/

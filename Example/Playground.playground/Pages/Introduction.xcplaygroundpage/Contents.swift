import Foundation
import Genything
import Trickery
/*:
 ![Genything Icon](icon.png)
 
 # What is Genything?
 Genything is a library dedicated to easy and composable generation of random data, no matter how complex.
 
 ## Motivation
 Genything was created from the necessity for flexible generation of random data. We wanted easy and composable data generation with support for deterministic results and stateful generators.
 
 This library takes inspiration from [Combine](https://developer.apple.com/documentation/combine), notably for designing operators. Users of Genything are therefore able to quickly compose complex generators using familiar functions such as `map`, `flatmap`, `zip` and many more. When it comes to generators for property based testing, [SwiftCheck](https://github.com/typelift/SwiftCheck) was taken into consideration. An example of this is with Genything's `testAllSatisfy` function which is similar to SwiftCheck's `forAll`.
 
 ## What sets Genything apart?
 The existing libraries for data data generation are usually specific to property based testing and have hard requirements. One limitation seen in current solutions is not being able to use the same generator in an example app and within unit tests. There is also no abstraction of randomness and limited support for result reproducibility.
 - - -
 */
/*: ### What is a Generator?
 A way to generate random values of a given type with a context that lets us decide how random we would like to be. */

let boolGenerator = AnyGenerator<Bool> { randomSource in /// `RandomSource` which
    Bool.random(using: &randomSource.rng)                /// lets us control the randomness
}








/*: ### How can we create a generator?
 The most common way to create a generator is using `arbitrary`. This property is available for most Swift types. We can also implement the `Arbitrary` protocol to unlock this property for our custom types. */

let digitGenerator: AnyGenerator<Int> = (0...9).arbitrary

/// If we want pseudo-realistic fake data we can import Trickery and use Fake.
/// We can also use operators to compose complex generators. This will be looked into further in the next page of the playground.
let fakeDigitGenerator: AnyGenerator<Int> = Fake.Numerics.digits








/*: ### How can we get values out of a generator?
 The main functions to extract values from a generator are:
 * `next(_:)` which produces the next element from this generator
 * `take(_:,randomSource:)` which returns an array of values from the generator
 * `sequence(_:,randomSource:)` which returns a sequence of this generator's values which will produce `nil` after `size` iterations */
/// A RandomSource is needed to provide a context with which to generate the random values.
let randomSource = RandomSource.predetermined()

let generatedInt = digitGenerator.next(randomSource) /// Returns the next value from the generator, here an integer

let generatedArray = digitGenerator.take(5, randomSource: .predetermined()) /// Returns an array of 5 integers taken from the generator
let generatedFiniteSequence = digitGenerator.sequence(5, randomSource: .predetermined()) /// returns a sequence of 5 integers.

/// Essentially `.take()` wraps a finite sequence in an array:
assert(Array(generatedFiniteSequence) == generatedArray)

let generatedSequence = digitGenerator.sequence(randomSource: randomSource) /// Returns a sequence of infinite elements from the integer generator.








/*: ### What is a `RandomSource`?
 A `RandomSource` enables us to control the randomness of the generated data.
 Using the following static methods we can conveniently create deterministic and nondeterministic random sources:
 * `predetermined(seed:)` allows us to provide deterministic results based on a default or custom seed,
 * `replay(seed:)` allows us to use an existing seed in order to obtain reproducible results. This is useful when debugging unit tests after extracting the seed from a previous generator
 * `random()` creates a nondeterministic random source */

/// Under the hood Genything uses a linear congruential random number generator wich allows us to reproduce the same values for particular seed.

/// Under the hood Genything uses a linear congruential random number generator wich allows us to reproduce the same values for particular seed.

let deterministicValue = digitGenerator.next(.predetermined()) /// The seed used here is the default one, i.e `2022`

let seededDeterministicValue = digitGenerator.next(.predetermined(seed: 42)) /// Here we use a custom seed, i.e `42`

let randomValue = digitGenerator.next(.random()) /// This results will use a random seed which you can replay if needed

/// If we pass the same randomSource to different generators we will get new results as the seed to randomize the data will change. This will be discussed more in the Stateful generators playground page.
let newRandomSourceWithDefaultSeed = digitGenerator.next(.predetermined())
let newRandomSourceWithTheSameSeed = digitGenerator.next(.predetermined())

let existingRandomSource = digitGenerator.next(randomSource)
let existingRandomSourceWithNewSeed = digitGenerator.next(randomSource)

assert(newRandomSourceWithDefaultSeed == newRandomSourceWithTheSameSeed)
assert(existingRandomSource != existingRandomSourceWithNewSeed)

//: [Composing with Operators](@next)

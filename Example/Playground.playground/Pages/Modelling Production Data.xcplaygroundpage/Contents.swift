import Foundation
import Genything
import GenythingTest
import Trickery
import XCTest

// Before this, we've seen how Genything can be used to generate mostly numbers. But we're developing real apps, not doing equations!
// Let's take some example models that more closely resemble how apps are made:

enum Handedness { case left, right, ambi }

struct User {
    var id: UUID
    var name: String
    var age: Int
    var handedness: Handedness
}

// Genything is more than happy to be used to model more complex data types, you can compose it's generators to fill each of the object's properties.

let userGenerator = AnyGenerator { rs in
    User(
        id: UUID.arbitrary.next(rs),
        name: String.arbitrary.next(rs),
        age: Int.arbitrary.next(rs),
        handedness: [Handedness.left, .right, .ambi].arbitrary.next(rs)
    )
}

userGenerator.next(.predetermined()) /// Returns: An arbitrary user

// As you can see it is not difficult to create a generator which is capable of quickly providing us with arbitrary users of our system. But we can do even better!

// 1. By adopting CaseIterable, we can auto-synthesize arbitrary conformance for Handedness
// 2. By trusting Swift's type inferance engine, we can do some cleaning up

extension Handedness: CaseIterable {}

AnyGenerator { rs in
    User(
        id: .arbitrary.next(rs),
        name: .arbitrary.next(rs),
        age: .arbitrary.next(rs),
        handedness: .arbitrary.next(rs)
    )
}

// 🎉 Much better! Genything even offers a composer which takes this one step further (but is by no means required knowledge)

Generators.compose { generate in
    User(
        id: generate(),
        name: generate(),
        age: generate(),
        handedness: generate()
    )
}

// By conforming your type to `Arbitrary` you can provide this common generator for anyone wishing to build an Example / Preview / Test which depends on this model.

extension User: Arbitrary {
    static var arbitrary: AnyGenerator<User> {
        Generators.compose { generate in
            User(
                id: generate(),
                name: generate(),
                age: generate(),
                handedness: generate()
            )
        }
    }
}

// 🕵️ If you've noticed that every line is the same, and that this is a great candidate for code generation, you would be right. Genything offers Sourcery templates to automatically create arbitrary generators for all of your models.

// ---

// 🙋 > "But this generator is really... arbitrary! I have specific requirements for my Example / Preview / Test."

// We recommend that teams first create arbitrary representations of their models, but then adapt them to the situation at hand.

// For example, if you are required to test a routine that only occurs if the user is an adult:

extension User {
    var isAdult: Bool { age >= 18 }
}

// You may want a random space from which to draw Users that are **over** 18, and another from which to draw users that are **below** 18

// This can be done by regenerating (or recomposing) the data type

let over18UserGen = User.arbitrary.regenerate { user, randomSource in
    user.age = (18...Int.max).arbitrary.next(randomSource)
}

over18UserGen.next(.predetermined()) /// Returns: An arbitrary user with age >= 18

let under18UserGen = User.arbitrary.regenerate { user, randomSource in
    user.age = (0..<18).arbitrary.next(randomSource)
}

under18UserGen.next(.predetermined()) /// Returns: An arbitrary user with age < 18

// We assume that the routine should be invariant to any other User property other than the age
// By leaving the other properties arbitrary, and conducting multiple tests, we can be reasonably sure of this assumption

class TestAgeRouting: XCTestCase {
    func test_givenUnder18Users_isAdult_returnsFalse() {
        testAllSatisfy(under18UserGen) { user in
            !user.isAdult
        }
    }
}

TestAgeRouting.defaultTestSuite.run()

// ---

// 🧑‍🎨 > "This data is still very arbitrary, how can I generate nice previews and example apps"

// In this case we can reach for `Trickery`, a companion library of **realistic** generators.

User.arbitrary.recompose { user, generate in
    user.name = generate(Fake.PersonNames.name)
    user.age = generate((0...100).arbitrary)
}

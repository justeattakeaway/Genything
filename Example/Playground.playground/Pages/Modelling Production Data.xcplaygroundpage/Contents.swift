import Foundation
import Genything
import GenythingTest
import XCTest
import SwiftUI
import PlaygroundSupport
















/*:
 Before this, we've seen how Genything can be used to generate integers. But we're developing real apps, not doing equations!

 Let's take a look at a model that more closely resembles something from an app:
*/
struct User: Identifiable {
    var id: UUID
    var name: String
    var age: Int
    var handedness: Handedness

    enum Handedness {
        case left, right, ambidextrous
    }
}








//: We can build a generator for this model using the AnyGenerator factory
AnyGenerator { rs in
    User(
        id: UUID.arbitrary.next(rs),
        name: .arbitrary.next(rs), /// We can even omit the type and let Swift infer it
        age: .arbitrary.next(rs),
        handedness: .arbitrary.next(rs)
    )
}




//: By adopting CaseIterable, we can auto-synthesize arbitrary conformance for Handedness
extension User.Handedness: CaseIterable {}








//: Genything also offers a composer which simplifies the factory by automatically searching for arbitrary conformance and performing the generation
Generators.compose { generate in
    User(
        id: generate(),
        name: generate(),
        age: generate(),
        handedness: generate()
    )
}









//: By conforming your type to Arbitrary you can make the User available to any subsequent generators or composers
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
/*:
 🕵️ "This looks like boilerplate, I bet you could generate this code..."

 You would be right! Genything offers Sourcery templates to automatically create arbitrary generators for all of your models.
 */









/*:
 Let's take a look at a practical example. Consider some function `isAdult(user:)`, which we want to write some unit tests to verify.
*/
func isAdult(_ user: User) -> Bool {
    user.age >= 18
}









/*:
 A traditional pattern to test this might look something like the following.

 It's up to the developer to choose adequate values for the test, including edge cases.
 Models can grow to be quite large, and it can become difficult to initialize all of the properties with dummy data.

 We also are not likely to test the scenario with different properties, we can't say that "an 18 year old user is an adult no matter what their name is, which hand is dominant, or what ID they may have".
 */
class TestAgeTraditional: XCTestCase {
    func makeSut(age: Int) -> User {
        User(id: UUID(), name: "", age: age, handedness: .right)
    }

    func test_givenUnder18Users_isAdult_isFalse_forAChild() {
        var sut = makeSut(age: 0)
        XCTAssertFalse(isAdult(sut))
        sut.age = 17
        XCTAssertFalse(isAdult(sut))
    }

    func test_givenUnder18Users_isAdult_isFalse_forEdgeCases() {
        var sut = makeSut(age: -1)
        XCTAssertFalse(isAdult(sut))
        sut.age = Int.min
        XCTAssertFalse(isAdult(sut))
    }
}

/// Uncomment to see it in action
// TestAgeTraditional.defaultTestSuite.run()









/*:
 Using Genything we can test that our function is invariant. We assume that for the entire set of possible inputs, as long as our particular condition is satisfied, the result holds. By testing with arbitrary random data for all properties and conducting multiple tests we can be _reasonably_ sure of our assumption.
 */

class TestAgeUsingGenything: XCTestCase {
    // We can regenerate the user generator we created previously
    let under18UserGen = User.arbitrary.regenerate { user, randomSource in
        user.age = (0..<18).arbitrary.next(randomSource) // and we can adapt it to only return users <18 years old
    }
    // Then using GenythingTest we can use it's test functions
    func test_givenUnder18Users_isAdult_returnsFalse() {
        // for all users where age is 0..<18
        testAllSatisfy(under18UserGen) { user in
            // the following condition should hold
            !isAdult(user)
        }
    }
}

/// Uncomment to see it in action
// TestAgeUsingGenything.defaultTestSuite.run()








/*:
 What sets Genything apart is that it is not _just_ a property testing framework. The same generators can be used for Example Apps, Automation Stubs, Screenshot Tests, or to stub data during development.

 Let's see the generator we built in action:
 */
struct UserDirectory: View {
    var users: [User]
    var body: some View {
        List(users) { user in
            HStack {
                Text(user.name)
                switch user.handedness {
                    case .left: Text("🫲")
                    case .right: Text("🫱")
                    case .ambidextrous: Text("🫲🫱")
                }
            }
        }
    }
}

let tenUsers = User.arbitrary
    .take(10, randomSource: .predetermined())

/// Uncomment to see it in action
// PlaygroundPage.current.setLiveView(UserDirectory(users: tenUsers))









/*:
 🧑‍🎨 "This data is still very arbitrary, how can I generate nice previews and example apps"
 
 In this case we can use `Trickery`, a companion library full of **realistic** generators.
 */
import Trickery

User.arbitrary.recompose { user, generate in
    user.name = generate(Trickery.Fake.PersonNames.full())
}

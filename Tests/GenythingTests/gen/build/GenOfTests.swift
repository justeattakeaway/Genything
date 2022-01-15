import XCTest
@testable import Genything

final internal class GenOfTests: XCTestCase {
    func test_from_createGenerator() {
        let gen = Gen.of([0, 1, 2])
        let sample = gen.take()

        XCTAssert(sample.contains(0))
        XCTAssert(sample.contains(1))
        XCTAssert(sample.contains(2))
        XCTAssert(sample.allSatisfy { $0 == 0 || $0 == 1 || $0 == 2 })
    }


    func test_exhaust() {
        let samples = Gen.exhaust([0, Int.max], then: Gen.from(0...Int.max))
            .samples()

        XCTAssertEqual(0, samples[0])
        XCTAssertEqual(Int.max, samples[1])

        print("!@# samples \(samples)")
    }

    func test_wow() {
        Gen.looping(0...10).forEach {
            print($0)
        }

        Gen.looping([Gen.constant("a"), Gen.constant("b")]).forEach {
            print($0)
        }
    }

    func test_whoah() {
        Gen.constant(10).startWith(Array(0...9)).take(20).forEach {
            print($0)
        }
    }
}

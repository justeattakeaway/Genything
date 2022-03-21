import XCTest
@testable import Genything

final internal class GenContextTests: XCTestCase {
    func test_using_a_randomSource() {
        // A new randomSource is created each execution
        XCTAssertEqual(
            Int.arbitrary.next(.default),
            Int.arbitrary.next(.default)
        )

        // To introduce randomness we need to track our randomSource
        let randomSource = RandomSource(determinism: .predetermined(seed: 0))

        XCTAssertNotEqual(
            Int.arbitrary.next(randomSource),
            Int.arbitrary.next(randomSource)
        )
    }

    func test_generate_one_with_same_seed_produces_same() {
        let calls = (1...100).map { _ in
            Generators.from(1...100).next(.default)
        }

        let allCallsAreSame = calls.allSatisfy {
            $0 == calls[0]
        }

        XCTAssertTrue(allCallsAreSame)
    }

    func test_generate_one_with_propogated_rng_produces_differently() {
        let ctx = RandomSource(determinism: .predetermined(seed: 0))

        let calls = (0..<100).map { _ in
            Generators.from(1...100).next(ctx)
        }

        let distribution = calls.reduce(into: [Int:Int]()) { (acc, curr) in
            acc[curr] = (acc[curr] ?? 0) + 1
        }

        XCTAssertTrue(distribution.count > 10)
    }

    func test_multiple_takes_with_propagated_rng_produce_differently() {
        let ctx = RandomSource(determinism: .predetermined(seed: 0))

        let first = Generators.from(1...100).take(100, randomSource: ctx)
        let second = Generators.from(1...100).take(100, randomSource: ctx)

        XCTAssertNotEqual(first, second)
    }

    func test_multiple_calls_with_same_seed_produce_same() {
        let first = Generators.from(1...100).take(1000)
        let second = Generators.from(1...100).take(1000)

        XCTAssertEqual(first, second)
    }

    func test_zipped_generators_draw_from_the_same_rng_and_produce_differently() {
        let result = Generators.zip(
            Generators.from(1...100),
            Generators.from(1...100)
        ).take(1000)

        XCTAssertNotEqual(
            result.map { $0.0 },
            result.map { $0.1 }
        )
    }
}

import XCTest
import Genything

class Gen_UniqueTests: XCTestCase {
    func test_uniquing_where_it_is_not_possible() {
        XCTAssertThrowsError(
            try Gen.constant(true).unique().safe.take()
        )
    }

    func test_uniquing_where_it_is_possible() {
        let digitGenerator = Gen.from(0...9)

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            digitGenerator.unique().take(10).sorted()
        )

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            digitGenerator.unique().take(10).sorted()
        )
    }

    func test_uniquing_with_compose() {

        // In order to `unique` while using `compose` we must put the `unique` outside of the composition block
        let digitGenerator = Gen.from(0...9).unique()
        let correctComposedUniqueGenerator = Gen.compose { c in
            c.generate(digitGenerator)
        }

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            correctComposedUniqueGenerator.take(10).sorted()
        )

        // Otherwise the generator will be created occur once per generation
        // As the unique values are stored per-generator
        // this leads to having no other values to unique against

        let incorrectComposedDigitGenerator = Gen.compose { c in
            c.generate(Gen.from(0...9).unique())
        }

        // We do not expect to receive unique values
        XCTAssertNotEqual(
            [0,1,2,3,4,5,6,7,8,9],
            incorrectComposedDigitGenerator.take(10).sorted()
        )
    }


    func test_uniquing_with_zip() {
        let gen = Gen.from(0...9)
        let tupleValues = gen.unique().zip(with: gen.unique()).take(10)
        let values0 = tupleValues.map { $0.0 }.sorted()
        let values1 = tupleValues.map { $0.1 }.sorted()

        let expected = [0,1,2,3,4,5,6,7,8,9]

        XCTAssertEqual(expected, values0)
        XCTAssertEqual(expected, values1)
    }
}

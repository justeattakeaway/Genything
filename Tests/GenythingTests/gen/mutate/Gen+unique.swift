import XCTest
import Genything

class Gen_UniqueTests: XCTestCase {
    func test_uniquing_where_it_is_possible() {
        let digitGenerator = Gen.from(0...9).unique()

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            digitGenerator.take(count: 10).sorted()
        )

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            digitGenerator.take(count: 10).sorted()
        )
    }

    func test_uniquing_with_compose() {

        // In order to `unique` with `compose` the generator must be created
        // outside of the composition.
        let digitGenerator = Gen.from(0...9)
        let correctComposedUniqueGenerator = Gen.compose { c in
            c.generate(digitGenerator.unique())
        }

        XCTAssertEqual(
            [0,1,2,3,4,5,6,7,8,9],
            correctComposedUniqueGenerator.take(count: 10).sorted()
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
            incorrectComposedDigitGenerator.take(count: 10).sorted()
        )
    }
}

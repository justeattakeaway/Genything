import Genything
import GenythingTest
import XCTest

internal final class TestAllTests: XCTestCase {

    // MARK: Internal

    func test_all_passes_when_it_should_with_correct_iterations() {
        var count = 0
        testAll(genTrue) {
            count += 1
            XCTAssertTrue($0)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_2() {
        var count = 0
        testAll(genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_3() {
        var count = 0
        testAll(genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_4() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_5() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_6() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_7() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_8() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_9() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7 && $8)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_10() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7 && $8 && $9)
        }

        XCTAssertEqual(GenythingTestConfig.default().maxIterations, count)
    }

    func test_all_fails_when_it_should() {
        XCTExpectFailure()
        testAll((1 ... 100).arbitrary) { a in
            XCTAssert(a < 1)
        }
    }

    // MARK: Private

    private var genVoid = Generators.constant(())
    private var genTrue = Generators.constant(true)

}

import XCTest
import Genything
import GenythingTest

final internal class CheckAllTests: XCTestCase {

    private var genVoid = Gen.constant(())
    private var genTrue = Gen.constant(true)

    func test_check_passes_when_it_should_with_correct_iterations() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, context: context) {
            count += 1
            XCTAssertTrue($0)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_2() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_3() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_4() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_5() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_6() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_7() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_8() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_passes_when_it_should_9() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7 && $8)
        }

        XCTAssertEqual(context.maxIterations, count)
    }


    func test_check_passes_when_it_should_10() {
        let context = Context.default
        context.maxIterations = 999

        var count = 0
        checkAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, genTrue, context: context) {
            count += 1
            XCTAssertTrue($0 && $1 && $2 && $3 && $4 && $5 && $6 && $7 && $8 && $9)
        }

        XCTAssertEqual(context.maxIterations, count)
    }

    func test_check_fails_when_it_should() {
        XCTExpectFailure()
        checkAll(Gen.from(1...100)) { a in
            XCTAssert(a < 1)
        }
    }
}

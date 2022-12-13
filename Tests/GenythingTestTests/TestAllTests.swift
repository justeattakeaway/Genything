import Genything
import GenythingTest
import XCTest

internal final class TestAllTests: XCTestCase {

    func test_all_passes_when_it_should_with_correct_iterations() {
        var count = 0
        testAll(genTrue) { assert, value in
            count += 1
            assert(value)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_2() {
        var count = 0

        testAll(genTrue, genTrue) { assert, v1, v2 in
            count += 1
            assert(v1 && v2)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_3() {
        var count = 0
        testAll(genTrue, genTrue, genTrue) { assert, v1, v2, v3 in
            count += 1
            assert(v1 && v2 && v3)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_4() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue) { assert, v1, v2, v3, v4 in
            count += 1
            assert(v1 && v2 && v3 && v4)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_5() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue) { assert, v1, v2, v3, v4, v5 in
            count += 1
            assert(v1 && v2 && v3 && v4 && v5)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_passes_when_it_should_6() {
        var count = 0
        testAll(genTrue, genTrue, genTrue, genTrue, genTrue, genTrue) { assert, v1, v2, v3, v4, v5, v6 in
            count += 1
            assert(v1 && v2 && v3 && v4 && v5 && v6)
        }

        XCTAssertEqual(TestConfig.default().maxIterations, count)
    }

    func test_all_fails_when_it_should() {
        XCTExpectFailure()
        testAll((1 ... 100).arbitrary) { assert, a in
            assert(a < 1)
        }
    }

    private var genVoid = Generators.constant(())
    private var genTrue = Generators.constant(true)

}

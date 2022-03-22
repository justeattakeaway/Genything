import XCTest
@testable import Genything
import GenythingTest

final internal class GenZipTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    // MARK: - Basic tests

    func test_anyGen_zippedWithAnotherGen_generateTupleOfExpectedValues() {
        let firstRange = 0..<100
        let secondRange = 100..<200
        let firstGen = firstRange.arbitrary
        let secondGen = secondRange.arbitrary

        let zipped = firstGen.zip(secondGen)
        testAll(zipped) { (first, second) in
            XCTAssertTrue(firstRange.contains(first))
            XCTAssertTrue(secondRange.contains(second))

            XCTAssertFalse(secondRange.contains(first))
            XCTAssertFalse(firstRange.contains(second))
        }
    }

    func test_anyGen_zipAndTransformAnotherGen_generateExpectedValues() {
        let firstGen = (Character("a")...Character("z")).arbitrary
        let secondGen = (Character("A")...Character("Z")).arbitrary

        let zipped = firstGen.zip(secondGen) { "\($0)\($1)" }
        testAll(zipped) { combined in
            XCTAssertTrue(combined.first?.isLowercase ?? false)
            XCTAssertTrue(combined.last?.isUppercase ?? false)
        }
    }

    // MARK: - Static zip of variable tuple size tests

    func test_3Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 3) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2]
            ).next(.default)
        }
    }

    func test_4Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 4) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2], gens[3]
            ).next(.default)
        }
    }

    func test_5Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 5) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4]
            ).next(.default)
        }
    }
//
//    func test_6Gen_staticZip_generateExpectedValues() {
//        testZip(argsCount: 6) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5]
//            ).next(.default)
//        }
//    }
//
//    func test_7Gen_staticZip_generateExpectedValues() {
//        testZip(argsCount: 7) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6]
//            ).next(.default)
//        }
//    }
//
//    func test_8Gen_staticZip_generateExpectedValues() {
//        testZip(argsCount: 8) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7]
//            ).next(.default)
//        }
//    }
//
//    func test_9Gen_staticZip_generateExpectedValues() {
//        testZip(argsCount: 9) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7], gens[8]
//            ).next(.default)
//        }
//    }
//
//    func test_10Gen_staticZip_generateExpectedValues() {
//        testZip(argsCount: 10) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7], gens[8], gens[9]
//            ).next(.default)
//        }
//    }

    private func testZip(argsCount: Int, zipCall: ([AnyGenerator<Int>]) -> Any) {
        let gens = createGens(argsCount)
        let tuple = zipCall(gens)
        validate(tuple, argsCount)
    }

    private func createGens(_ count: Int) -> [AnyGenerator<Int>] {
        (0..<count).map { index in
            Generators.constant(index).eraseToAnyGenerator()
        }
    }

    private func validate(_ tuple: Any, _ count: Int) {
        let values = Mirror(reflecting: tuple).children.map { $0.value as! Int }
        XCTAssertEqual(values, Array(0..<count))
    }

    // MARK: - Static zip+transform of variable tuple size tests

    func test_3Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 3) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2]
            ){ a, b, c in
                a+b+c
            }
            .next(.default)
        }
    }

    func test_4Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 4) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2], gens[3]
            ){ a, b, c, d in
                a+b+c+d
            }
            .next(.default)
        }
    }

    func test_5Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 5) { gens in
            Generators.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4]
            ){ a, b, c, d, e in
                a+b+c+d+e
            }
            .next(.default)
        }
    }
//
//    func test_6Gen_staticZipTransform_generateExpectedValues() {
//        testZipTransform(argsCount: 6) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5]
//            ){ a, b, c, d, e, f in
//                a+b+c+d+e+f
//            }
//            .next(.default)
//        }
//    }
//
//    func test_7Gen_staticZipTransform_generateExpectedValues() {
//        testZipTransform(argsCount: 7) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6]
//            ){ a, b, c, d, e, f, g in
//                a+b+c+d+e+f+g
//            }
//            .next(.default)
//        }
//    }
//
//    func test_8Gen_staticZipTransform_generateExpectedValues() {
//        testZipTransform(argsCount: 8) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7]
//            ){ a, b, c, d, e, f, g, h in
//                a+b+c+d+e+f+g+h
//            }
//            .next(.default)
//        }
//    }
//
//    func test_9Gen_staticZipTransform_generateExpectedValues() {
//        testZipTransform(argsCount: 9) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7], gens[8]
//            ){ a, b, c, d, e, f, g, h, i in
//                a+b+c+d+e+f+g+h+i
//            }
//            .next(.default)
//        }
//    }
//
//    func test_10Gen_staticZipTransform_generateExpectedValues() {
//        testZipTransform(argsCount: 10) { gens in
//            Gen.zip(
//                gens[0], gens[1], gens[2], gens[3], gens[4],
//                gens[5], gens[6], gens[7], gens[8], gens[9]
//            ){ a, b, c, d, e, f, g, h, i, j in
//                a+b+c+d+e+f+g+h+i+j
//            }
//            .next(.default)
//        }
//    }

    private func testZipTransform(argsCount: Int, zipCall: ([AnyGenerator<Int>]) -> Int) {
        let gens = createGens(argsCount)
        let total = zipCall(gens)
        XCTAssertEqual(total, (0..<argsCount).reduce(0, +))
    }
}

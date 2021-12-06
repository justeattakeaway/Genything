import XCTest
@testable import Genything

final internal class GenZipTests: XCTestCase {
    override func setUp() {
        continueAfterFailure = false
    }

    // MARK: - Basic tests

    func test_anyGen_zippedWithAnotherGen_generateTupleOfExpectedValues() {
        let firstRange = 0..<100
        let secondRange = 100..<200
        let firstGen = Gen.from(firstRange)
        let secondGen = Gen.from(secondRange)

        let zipped = firstGen.zip(with: secondGen)
        zipped.forEach { (first, second) in
            XCTAssertTrue(firstRange.contains(first))
            XCTAssertTrue(secondRange.contains(second))

            XCTAssertFalse(secondRange.contains(first))
            XCTAssertFalse(firstRange.contains(second))
        }
    }

    func test_anyGen_zipAndTransformAnotherGen_generateExpectedValues() {
        let firstGen = Gen<Character>.from("a"..."z")
        let secondGen = Gen<Character>.from("A"..."Z")

        let zipped = firstGen.zip(with: secondGen) { "\($0)\($1)" }
        zipped.forEach { combined in
            XCTAssertTrue(combined.first?.isLowercase ?? false)
            XCTAssertTrue(combined.last?.isUppercase ?? false)
        }
    }

    // MARK: - Static zip of variable tuple size tests

    func test_3Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 3) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2]
            ).generate()
        }
    }

    func test_4Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 4) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3]
            ).generate()
        }
    }

    func test_5Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 5) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4]
            ).generate()
        }
    }

    func test_6Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 6) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5]
            ).generate()
        }
    }

    func test_7Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 7) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6]
            ).generate()
        }
    }

    func test_8Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 8) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7]
            ).generate()
        }
    }

    func test_9Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 9) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8]
            ).generate()
        }
    }

    func test_10Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 10) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9]
            ).generate()
        }
    }

    private func testZip(argsCount: Int, zipCall: ([Gen<Int>]) -> Any) {
        let gens = createGens(argsCount)
        let tuple = zipCall(gens)
        validate(tuple, argsCount)
    }

    private func createGens(_ count: Int) -> [Gen<Int>] {
        (0..<count).map { index in
            Gen<Int>.constant(index)
        }
    }

    private func validate(_ tuple: Any, _ count: Int) {
        let values = Mirror(reflecting: tuple).children.map { $0.value as! Int }
        XCTAssertEqual(values, Array(0..<count))
    }

    // MARK: - Static zip+transform of variable tuple size tests

    func test_3Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 3) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2]
            ){ a, b, c in
                a+b+c
            }
            .generate()
        }
    }

    func test_4Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 4) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3]
            ){ a, b, c, d in
                a+b+c+d
            }
            .generate()
        }
    }

    func test_5Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 5) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4]
            ){ a, b, c, d, e in
                a+b+c+d+e
            }
            .generate()
        }
    }

    func test_6Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 6) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5]
            ){ a, b, c, d, e, f in
                a+b+c+d+e+f
            }
            .generate()
        }
    }

    func test_7Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 7) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6]
            ){ a, b, c, d, e, f, g in
                a+b+c+d+e+f+g
            }
            .generate()
        }
    }

    func test_8Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 8) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7]
            ){ a, b, c, d, e, f, g, h in
                a+b+c+d+e+f+g+h
            }
            .generate()
        }
    }

    func test_9Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 9) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8]
            ){ a, b, c, d, e, f, g, h, i in
                a+b+c+d+e+f+g+h+i
            }
            .generate()
        }
    }

    func test_10Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 10) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9]
            ){ a, b, c, d, e, f, g, h, i, j in
                a+b+c+d+e+f+g+h+i+j
            }
            .generate()
        }
    }

    private func testZipTransform(argsCount: Int, zipCall: ([Gen<Int>]) -> Int) {
        let gens = createGens(argsCount)
        let total = zipCall(gens)
        XCTAssertEqual(total, (0..<argsCount).reduce(0, +))
    }
}

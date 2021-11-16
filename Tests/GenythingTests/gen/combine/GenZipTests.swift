import XCTest
@testable import Genything

final internal class GenZipTests: XCTestCase {
    // MARK: - Basic tests

    func test_anyGen_zipWithAnotherGen_generateTupleOfExpectedValues() {
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

    func test_11Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 11) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10]
            ).generate()
        }
    }

    func test_12Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 12) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11]
            ).generate()
        }
    }

    func test_13Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 13) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12]
            ).generate()
        }
    }

    func test_14Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 14) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13]
            ).generate()
        }
    }

    func test_15Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 15) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14]
            ).generate()
        }
    }

    func test_16Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 16) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15]
            ).generate()
        }
    }

    func test_17Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 17) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16]
            ).generate()
        }
    }

    func test_18Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 18) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17]
            ).generate()
        }
    }

    func test_19Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 19) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18]
            ).generate()
        }
    }

    func test_20Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 20) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19]
            ).generate()
        }
    }

    func test_21Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 21) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19],
                gens[20]
            ).generate()
        }
    }

    func test_22Gen_staticZip_generateExpectedValues() {
        testZip(argsCount: 22) { gens in
            Gen.zip(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19],
                gens[20], gens[21]
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
            Gen.zipWith(
                gens[0], gens[1], gens[2]
            ){ a, b, c in
                a+b+c
            }
            .generate()
        }
    }

    func test_4Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 4) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3]
            ){ a, b, c, d in
                a+b+c+d
            }
            .generate()
        }
    }

    func test_5Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 5) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4]
            ){ a, b, c, d, e in
                a+b+c+d+e
            }
            .generate()
        }
    }

    func test_6Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 6) { gens in
            Gen.zipWith(
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
            Gen.zipWith(
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
            Gen.zipWith(
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
            Gen.zipWith(
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
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9]
            ){ a, b, c, d, e, f, g, h, i, j in
                a+b+c+d+e+f+g+h+i+j
            }
            .generate()
        }
    }

    func test_11Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 11) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10]
            ){ a, b, c, d, e, f, g, h, i, j, k in
                a+b+c+d+e+f+g+h+i+j+k
            }
            .generate()
        }
    }

    func test_12Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 12) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11]
            ){ a, b, c, d, e, f, g, h, i, j, k, l in
                a+b+c+d+e+f+g+h+i+j+k+l
            }
            .generate()
        }
    }

    func test_13Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 13) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m in
                a+b+c+d+e+f+g+h+i+j+k+l+m
            }
            .generate()
        }
    }

    func test_14Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 14) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n
            }
            .generate()
        }
    }

    func test_15Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 15) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o
            }
            .generate()
        }
    }

    func test_16Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 16) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p
            }
            .generate()
        }
    }

    func test_17Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 17) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q
            }
            .generate()
        }
    }

    func test_18Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 18) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r
            }
            .generate()
        }
    }

    func test_19Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 19) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s
            }
            .generate()
        }
    }

    func test_20Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 20) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t
            }
            .generate()
        }
    }

    func test_21Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 21) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19],
                gens[20]
            ){ a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t+u
            }
            .generate()
        }
    }

    func test_22Gen_staticZipTransform_generateExpectedValues() {
        testZipTransform(argsCount: 22) { gens in
            Gen.zipWith(
                gens[0], gens[1], gens[2], gens[3], gens[4],
                gens[5], gens[6], gens[7], gens[8], gens[9],
                gens[10], gens[11], gens[12], gens[13], gens[14],
                gens[15], gens[16], gens[17], gens[18], gens[19],
                gens[20], gens[21]
            ) { a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p, q, r, s, t, u, v in
                a+b+c+d+e+f+g+h+i+j+k+l+m+n+o+p+q+r+s+t+u+v
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

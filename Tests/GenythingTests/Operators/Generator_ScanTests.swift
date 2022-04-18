//import GenythingTest
//import XCTest
//@testable import Genything
//
//final class Generator_ScanTests: XCTestCase {
//    /// Test that scan works as Combine users should expect
//    /// - SeeAlso: https://developer.apple.com/documentation/combine/publisher/scan(_:_:)
//    func test_scan_matches_combine_example() {
//        let range = 0 ... 5
//
//        let result = Exhaustive.Loop(range)
//            .scan(0) { $0 + $1 }
//            .take(range.count, randomSource: RandomSource())
//
//        XCTAssertEqual([0, 1, 3, 6, 10, 15], result)
//    }
//
//    func test_abusing_scan_to_create_iterator() {
//        let range = 0 ... 5
//
//        let result = Generators.constant(0)
//            .scan(0) { acc, _ in acc + 1 }
//            .take(range.count, randomSource: RandomSource())
//
//        XCTAssertEqual([1, 2, 3, 4, 5, 6], result)
//    }
//
//    func test_abusing_scan_to_create_iterator_of_even_values() {
//        let range = 0 ... 5
//
//        let result = Generators.constant(0)
//            .scan(0) { acc, _ in acc + 2 }
//            .take(range.count, randomSource: RandomSource())
//
//        XCTAssertEqual([2, 4, 6, 8, 10, 12], result)
//    }
//
//    func SKIP_test_modeling_a_moving_average() {
//        (0 ... 1)
//            .arbitrary
//            .debug("value")
//            .scan(0.0) { average, newValue in
//                average * 0.5 + Double(newValue) * 0.5
//            }
//            .debug("average")
//            .sequence(100, randomSource: RandomSource()).forEach { _ in }
//    }
//}

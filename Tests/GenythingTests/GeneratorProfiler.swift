@testable import Genything
import GenythingTest
import XCTest

final class GeneratorProfilerTests: XCTestCase {
    func test_profiler_runs_the_demanded_iterations() {
        let iterations = 1000
        let generations = GeneratorProfiler(Generators.void())
            .run(iterations: iterations)
            .generations
        
        XCTAssertEqual(generations, iterations)
    }

    func test_profiler_matches_expectations_for_average_randomizations() {
        /// Given completely random numbers this would have a `1/2` chance of occuring
        let isEven = { ($0 % 2) == 0 }
        
        /// Let's test that theory with the profiler
        let profile = GeneratorProfiler(Int.arbitrary.filter(isEven))
            .run(iterations: 1000)
        
        /// Given our hypothesis we would expect an average of ~2 randomizations per final value
        XCTAssertEqual(profile.averageRandomizations, 2, accuracy: 0.15)
    }
}

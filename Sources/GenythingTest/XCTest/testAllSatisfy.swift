import Foundation
import Genything

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition
public func testAllSatisfy<G1>(
    _ generator: G1,
    config: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T) throws -> Bool
) rethrows where G1: Generator {
    let result = try generator.test(config: config, predicate)

    switch result {
        case .success: return
        case .failure(let info):
            switch info.reason {
                case .predicate(let value):
                    fail(
                        "Test not satisfied with generated value `\(value)` on iteration `\(info.iteration).",
                        randomSource: config.randomSource,
                        file: file,
                        line: line
                    )
            }
    }
}

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
public func testAllSatisfy<G1, G2>(
    _ gen1: G1,
    _ gen2: G2,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T, G2.T) throws -> Bool
) rethrows where G1: Generator, G2: Generator {
    try testAllSatisfy(
        gen1.zip(gen2),
        file: file,
        line: line,
        predicate: predicate
    )
}

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
public func testAllSatisfy<G1, G2, G3>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T, G2.T, G3.T) throws -> Bool
) rethrows where G1: Generator, G2: Generator, G3: Generator {
    try testAllSatisfy(
        gen1.zip(gen2, gen3),
        file: file,
        line: line,
        predicate: predicate
    )
}

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
public func testAllSatisfy<G1, G2, G3, G4>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T, G2.T, G3.T, G4.T) throws -> Bool
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator {
    try testAllSatisfy(
        gen1.zip(gen2, gen3, gen4),
        file: file,
        line: line,
        predicate: predicate
    )
}

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
public func testAllSatisfy<G1, G2, G3, G4, G5>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    _ gen5: G5,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T, G2.T, G3.T, G4.T, G5.T) throws -> Bool
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator, G5: Generator {
    try testAllSatisfy(
        gen1.zip(gen2, gen3, gen4, gen5),
        file: file,
        line: line,
        predicate: predicate
    )
}

/// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
///
/// - Warning: This is a very complex check. You should first combine your generators using compose or zip into a tuple or struct before attempting to test.
///
/// - Parameters:
///   - file: The file this test was called from
///   - line: The line this test was called from
///   - randomSource: The randomSource to be used for generation
///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
public func testAllSatisfy<G1, G2, G3, G4, G5, G6>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    _ gen5: G5,
    _ gen6: G6,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    predicate: @escaping (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T) throws -> Bool
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator, G5: Generator, G6: Generator {
    try testAllSatisfy(
        Generators.compose {
            (
                $0(gen1),
                $0(gen2),
                $0(gen3),
                $0(gen4),
                $0(gen5),
                $0(gen6)
            )
        },
        file: file,
        line: line,
        predicate: predicate
    )
}

import Foundation
import Genything

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A throwing predicate will raise an `XCTFail`
///
public func testAll<G1>(
    _ gen1: G1,
    config: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T) throws -> Void
) rethrows where G1: Generator {
    var assertion = Assertion(config: config)
    let sequence = gen1.sequence(config.maxIterations, randomSource: config.randomSource).makeIterator()

    var i = 0
    var value = sequence.next()
    while assertion.failure == nil && value != nil {
        defer {
            value = sequence.next()
            i += 1
        }
        try body(&assertion, value!)
    }

    if let failure = assertion.failure, let value {
        fail(
            failure + " Generated value `\(value)` on iteration `\(i)`.",
            randomSource: config.randomSource,
            file: file,
            line: line
        )
    }
}

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - gen2: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A failing predicate will assert with `XCTFail`
///
public func testAll<G1, G2>(
    _ gen1: G1,
    _ gen2: G2,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T, G2.T) throws -> Void
) rethrows where G1: Generator, G2: Generator {
    try testAll(
        gen1.zip(gen2),
        file: file,
        line: line,
        {
            try body(&$0, $1.0, $1.1)
        }
    )
}

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - gen2: A generator who's values will be used for testing
///   - gen3: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A failing predicate will assert with `XCTFail`
///
public func testAll<G1, G2, G3>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T, G2.T, G3.T) throws -> Void
) rethrows where G1: Generator, G2: Generator, G3: Generator {
    try testAll(
        gen1.zip(gen2, gen3),
        file: file,
        line: line,
        {
            try body(&$0, $1.0, $1.1, $1.2)
        }
    )
}

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///

///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - gen2: A generator who's values will be used for testing
///   - gen3: A generator who's values will be used for testing
///   - gen4: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A failing predicate will assert with `XCTFail`
///
public func testAll<G1, G2, G3, G4>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T, G2.T, G3.T, G4.T) throws -> Void
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator {
    try testAll(
        gen1.zip(gen2, gen3, gen4),
        file: file,
        line: line,
        {
            try body(&$0, $1.0, $1.1, $1.2, $1.3)
        }
    )
}

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - gen2: A generator who's values will be used for testing
///   - gen3: A generator who's values will be used for testing
///   - gen4: A generator who's values will be used for testing
///   - gen5: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A failing predicate will assert with `XCTFail`
///
public func testAll<G1, G2, G3, G4, G5>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    _ gen5: G5,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T, G2.T, G3.T, G4.T, G5.T) throws -> Void
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator,
    G5: Generator {
    try testAll(
        gen1.zip(gen2, gen3, gen4, gen5),
        file: file,
        line: line,
        {
            try body(&$0, $1.0, $1.1, $1.2, $1.3, $1.4)
        }
    )
}

/// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
///
/// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
///
/// - Warning: This is a very complex check. You should first combine your generators using compose or zip into a tuple or struct before attempting to test.
///
/// - Parameters:
///   - randomSource: The randomSource to be used for generation
///   - gen1: A generator who's values will be used for testing
///   - gen2: A generator who's values will be used for testing
///   - gen3: A generator who's values will be used for testing
///   - gen4: A generator who's values will be used for testing
///   - gen5: A generator who's values will be used for testing
///   - gen6: A generator who's values will be used for testing
///   - body: A closure body where you may make your XCTest assertions
///
/// - Attention: A failing predicate will assert with `XCTFail`
///
public func testAll<G1, G2, G3, G4, G5, G6>(
    _ gen1: G1,
    _ gen2: G2,
    _ gen3: G3,
    _ gen4: G4,
    _ gen5: G5,
    _ gen6: G6,
    config _: TestConfig = .default(),
    file: StaticString = #filePath,
    line: UInt = #line,
    _ body: (inout Assertion, G1.T, G2.T, G3.T, G4.T, G5.T, G6.T) throws -> Void
) rethrows where G1: Generator, G2: Generator, G3: Generator, G4: Generator, G5: Generator, G6: Generator {
    try testAll(
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
        {
            try body(&$0, $1.0, $1.1, $1.2, $1.3, $1.4, $1.5)
        }
    )
}

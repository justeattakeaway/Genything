import Foundation

extension Generator {

    // MARK: Public

    /// Logs a print statement for each value produced by the receiver
    ///
    /// - Parameter tag: Optional tag which can be used to easily identify which debug statement a log belongs to
    ///
    /// - Returns: A generator which which produces identical values to the receiver
    public func debug(_ tag: String = "", file: StaticString = #fileID, line: UInt = #line) -> AnyGenerator<T> {
        let prefix: String = {
            if tag.isEmpty {
                return "\(file):\(line)"
            }
            return "\(tag)"
        }()

        return also {
            log(prefix, $0)
        }
    }

    // MARK: Private

    private func log(_ tag: String, _ value: T) {
        let timestamp = dateFormatter.string(from: Date())
        print("\(timestamp): [\(tag)] -> \(value)")
    }
}

private var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "HH:mm:ss.SSS"
    return df
}()

public struct TestSuite {
    public let config: TestConfig

    public init(config: TestConfig = .default()) {
        self.config = config
    }
}

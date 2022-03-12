extension StatefulGen {
    /// Returns: A generator produced by the factory which has been given a reference to the Context
    ///
    /// - Parameter factory: A factory which produces a Generator using the provided Context
    ///
    /// - Returns: The generator
    static func inContext(_ factory: @escaping (Context) throws -> StatefulGen<T>) -> StatefulGen<T> {
        StatefulGen {
            var generator: Gen<T>!
            return Gen { ctx in
                if generator == nil {
                    generator = try factory(ctx).start()
                }
                return generator.generate(context: ctx)
            }
        }
    }
}

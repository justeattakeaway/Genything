extension Generators {
    /// Returns: A Generator that constantly produces Void
    public static func void() -> AnyGenerator<()> {
        Generators.constant(())
    }
}

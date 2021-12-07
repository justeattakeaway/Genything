import Foundation

/// A service locator and cache which allows a context to hold onto arbitrary services for it's lifetime
final class ContextServiceLocator {
    private var store = [Int : Any]()

    /// Locates a service of type `Service`, creating it via `factory` if it does not exist already
    ///
    /// - Parameter factory: A factory capable of creating the service
    ///
    /// - Returns: The service
    func service<Service>(_ factory: @escaping () -> Service) -> Service {
        let key = Int(bitPattern: ObjectIdentifier(Service.self))

        if let service = store[key] as? Service {
            return service
        } else {
            let service = factory()
            store[key] = service
            return service
        }
    }
}

import Foundation
import Genything

extension Fake {
    public enum ID {
        public static var uuid: AnyGenerator<UUID> {
            UUID.arbitrary
        }
        public static var uuidString: AnyGenerator<String> {
            uuid.map { $0.uuidString }
        }
    }
}

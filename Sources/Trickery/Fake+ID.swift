import Foundation
import Genything

extension Fake {
    public enum ID {
        public static let uuid: Gen<UUID> = UUID.arbitrary
        public static let uuidString: Gen<String> = uuid.map { $0.uuidString }
    }
}

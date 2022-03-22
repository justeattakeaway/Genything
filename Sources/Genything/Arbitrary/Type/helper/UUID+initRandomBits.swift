import Foundation

extension UUID {

    typealias UInt128 = (UInt64, UInt64)

    private static var `nil`: UUID {
        UUID(uuid: (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
    }

    init(bits randomBits: UInt128, version: UInt8) {
        var factoryBytes = UUID.nil.uuid

        withUnsafeBytes(of: randomBits) { randomBytes in
            withUnsafeMutableBytes(of: &factoryBytes) { target in
                _ = randomBytes.copyBytes(to: target, count: 16)
            }
            factoryBytes.8 = factoryBytes.8 & 0x3f | 0x80
            factoryBytes.6 = factoryBytes.6 & 0x0f | version << 4
        }

        self.init(uuid: factoryBytes)
    }
}

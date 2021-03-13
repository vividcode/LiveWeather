enum Gibberish {
    private static let salt: [UInt8] = [
		0x13, 0x03, 0x18, 0xe4, 0x4e, 0xe1, 0xa3, 0x50,
		0x9d, 0xef, 0xcd, 0x5a, 0xf9, 0x5b, 0xfc, 0x3e,
		0x87, 0x26, 0x6c, 0x26, 0x0c, 0xa2, 0x2d, 0xf5,
		0xd1, 0x15, 0xe8, 0x52, 0x42, 0xe1, 0xa8, 0xbe,
		0xc3, 0xbb, 0x5b, 0x01, 0x45, 0x7f, 0xe8, 0x87,
		0x41, 0x3b, 0xa4, 0xcc, 0x62, 0xe6, 0xa1, 0xdb,
		0x23, 0xca, 0x67, 0x61, 0x80, 0x76, 0x67, 0x65,
		0xc7, 0x1a, 0xc7, 0x12, 0x09, 0x0d, 0x67, 0x3b
    ]

    static var baseURLDev: String {
        let encoded: [UInt8] = [
			0x7b, 0x77, 0x6c, 0x94, 0x3d, 0xdb, 0x8c, 0x7f,
			0xea, 0x98, 0xba, 0x74, 0x94, 0x3e, 0x88, 0x5f,
			0xf0, 0x43, 0x0d, 0x52, 0x64, 0xc7, 0x5f, 0xdb,
			0xb2, 0x7a, 0x85, 0x7d, 0x23, 0x91, 0xc1, 0x91
        ]

        return decode(encoded, cipher: salt)
    }

    static var baseURLProd: String {
        let encoded: [UInt8] = [
			0x7b, 0x77, 0x6c, 0x94, 0x3d, 0xdb, 0x8c, 0x7f,
			0xea, 0x98, 0xba, 0x74, 0x94, 0x3e, 0x88, 0x5f,
			0xf0, 0x43, 0x0d, 0x52, 0x64, 0xc7, 0x5f, 0xdb,
			0xb2, 0x7a, 0x85, 0x7d, 0x23, 0x91, 0xc1, 0x91,
			0xb3, 0xc9, 0x34, 0x65, 0x6a
        ]

        return decode(encoded, cipher: salt)
    }

    static var supportURL: String {
        let encoded: [UInt8] = [
			0x7b, 0x77, 0x6c, 0x94, 0x3d, 0xdb, 0x8c, 0x7f,
			0xfa, 0x86, 0xb9, 0x32, 0x8c, 0x39, 0xd2, 0x5d,
			0xe8, 0x4b, 0x43, 0x50, 0x65, 0xd4, 0x44, 0x91,
			0xb2, 0x7a, 0x8c, 0x37
        ]

        return decode(encoded, cipher: salt)
	}

    static func decode(_ encoded: [UInt8], cipher: [UInt8]) -> String {
        String(decoding: encoded.enumerated().map { (offset, element) in
            element ^ cipher[offset % cipher.count]
        }, as: UTF8.self)
    }
}

//
//  Data+RawLZ4Decoder.swift
//  flutter_platform_lz4
//
//  Created by Matheus Bastos on 25/01/23.
//

import Foundation
import Compression

extension Data {
    init?(rawLZ4CompressedData: Data, decompressedLength: Int) {
        let destinationBuffer = UnsafeMutablePointer<UInt8>.allocate(capacity: decompressedLength)
        
        let data = rawLZ4CompressedData.withUnsafeBytes { (pointerToEncodedData: UnsafeRawBufferPointer) -> Data? in
            let encodedDataBuffer = pointerToEncodedData.bindMemory(to: UInt8.self)
            let encodedDataAddress = encodedDataBuffer.baseAddress!
            
            let count = compression_decode_buffer(
                destinationBuffer,
                decompressedLength,
                encodedDataAddress,
                rawLZ4CompressedData.count,
                nil,
                COMPRESSION_LZ4_RAW)

            guard count > 0 else {
                return nil
            }
            
            return Data(bytesNoCopy: destinationBuffer, count: count, deallocator: .free)
        }
        
        guard let data = data else {
            destinationBuffer.deallocate()
            return nil
        }
        
        self = data
    }
}

//
//  CoreCrypto.swift
//  
//
//  Created by Michael Xu on 4/14/23.
//

import Foundation

// Wraps the Rust corecrypto library loosely, with xmtp-rust-swift bindings crate and swift-bridge in between
public class CoreCrypto {

    public static func sha256(data: Data) -> Data {
        // Make a RustVec from the Data
        let rustVec = RustVec<UInt8>()
        // TODO: Not amazing efficiency here
        for byte in data {
            rustVec.push(value: byte)
        }
        // Call the Rust sha256 function to get a RustVec back
        let result = XMTPRust.sha256(rustVec)
        var listBytes: [UInt8] = []
        for byte in result {
            listBytes.append(byte)
        }
        // Convert the RustVec to a Data
        return Data(listBytes)
    }

    public static func keccak256(data: Data) -> Data {
        // Make a RustVec from the Data
        let rustVec = RustVec<UInt8>()
        // TODO: Not amazing efficiency here
        for byte in data {
            rustVec.push(value: byte)
        }
        // Call the Rust keccak256 function to get a RustVec back
        let result = XMTPRust.keccak256(rustVec)
        var listBytes: [UInt8] = []
        for byte in result {
            listBytes.append(byte)
        }
        // Convert the RustVec to a Data
        return Data(listBytes)
    }
}

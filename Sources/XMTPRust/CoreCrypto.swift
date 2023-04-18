//
//  CoreCrypto.swift
//  
//
//  Created by Michael Xu on 4/14/23.
//

import Foundation

// Wraps the Rust corecrypto library loosely, with xmtp-rust-swift bindings crate and swift-bridge in between
public class CoreCrypto {

    // TODO: improve efficiency here, may be a swift-bridge limitation
    // since I looked through RustVec's API and didn't see any kind of
    // bulk load. Passing unsafe pointers might be a possible optimization
    static func rustVecFromData(data: Data) -> RustVec<UInt8> {
        let rustVec = RustVec<UInt8>()
        for byte in data {
            rustVec.push(value: byte)
        }
        return rustVec
    }

    static func dataFromRustVec(rustVec: RustVec<UInt8>) -> Data {
        var listBytes: [UInt8] = []
        for byte in rustVec {
            listBytes.append(byte)
        }
        return Data(listBytes)
    }

    public static func sha256(data: Data) -> Data {
        // Make a RustVec from the Data
        let rustVec = rustVecFromData(data: data)
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
        let rustVec = rustVecFromData(data: data)
        // Call the Rust keccak256 function to get a RustVec back
        let result = XMTPRust.keccak256(rustVec)
        var listBytes: [UInt8] = []
        for byte in result {
            listBytes.append(byte)
        }
        // Convert the RustVec to a Data
        return Data(listBytes)
    }

    public static func diffie_hellman_k256(privateKeyBytes: Data, publicKeyBytes: Data) throws -> Data {
        // Make a RustVec from the Data
        let rustVecPrivateKey = rustVecFromData(data: privateKeyBytes)
        let rustVecPublicKey = rustVecFromData(data: publicKeyBytes)
        // Call the Rust diffie_hellman_k256 function to get a RustVec back
        let byteResult: BytesResult = XMTPRust.diffie_hellman_k256(rustVecPrivateKey, rustVecPublicKey)
        if !byteResult.error.toString().isEmpty {
            throw NSError(domain: "XMTP", code: 0, userInfo: [NSLocalizedDescriptionKey: byteResult.error.toString()])
        }
        return dataFromRustVec(rustVec: byteResult.bytes)
    }

    public static func verify_k256_sha256(publicKeyBytes: Data, message: Data, signature: Data, recoveryId: UInt8) throws -> Bool {
        // Make a RustVec from the Data
        let rustVecPublicKey = rustVecFromData(data: publicKeyBytes)
        let rustVecMessage = rustVecFromData(data: message)
        let rustVecSignature = rustVecFromData(data: signature)
        // Result<(), String> in Rust becomes a throw in Swift and we ignore the return type
        let emptyResult: EmptyResult =  XMTPRust.verify_k256_sha256(rustVecPublicKey, rustVecMessage, rustVecSignature, recoveryId)
        if !emptyResult.error.toString().isEmpty {
            return false
        }
        return true
    }
}

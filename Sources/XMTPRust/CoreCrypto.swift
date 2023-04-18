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
    func rustVecFromData(data: Data) -> RustVec<UInt8> {
        let rustVec = RustVec<UInt8>()
        for byte in data {
            rustVec.push(value: byte)
        }
        return rustVec
    }

    func dataFromRustVec(rustVec: RustVec<UInt8>) -> Data {
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

// The goal is to replicate these functions with CoreCrypto
//	func sharedSecret(private privateData: Data, public publicData: Data) throws -> Data {
//		let publicKey = try secp256k1.Signing.PublicKey(rawRepresentation: publicData, format: .uncompressed)
//
//		let sharedSecret = try publicKey.multiply(privateData.bytes, format: .uncompressed)
//
//		return sharedSecret.rawRepresentation
//	}
//
//
//	func verify(signedBy: PublicKey, digest: Data) throws -> Bool {
//		let recoverySignature = try secp256k1.Recovery.ECDSASignature(compactRepresentation: ecdsaCompact.bytes, recoveryId: Int32(ecdsaCompact.recovery))
//		let ecdsaSignature = try recoverySignature.normalize
//		let signingKey = try secp256k1.Signing.PublicKey(rawRepresentation: signedBy.secp256K1Uncompressed.bytes, format: .uncompressed)
//
//		return signingKey.ecdsa.isValidSignature(ecdsaSignature, for: digest)
//	}
//
//	func verify(signedBy: PublicKey, digest: any Digest) throws -> Bool {
//		let recoverySignature = try secp256k1.Recovery.ECDSASignature(compactRepresentation: ecdsaCompact.bytes, recoveryId: Int32(ecdsaCompact.recovery))
//		let ecdsaSignature = try recoverySignature.normalize
//		let signingKey = try secp256k1.Signing.PublicKey(rawRepresentation: signedBy.secp256K1Uncompressed.bytes, format: .uncompressed)
//
//		return signingKey.ecdsa.isValidSignature(ecdsaSignature, for: digest)
//	}

// fn verify_k256_sha256(
//     public_key_bytes: Vec<u8>,
//     message: Vec<u8>,
//     signature: Vec<u8>,
//     recovery_id: u8,
// ) -> Result<(), String> {
//     k256_helper::verify_k256_sha256(
//         public_key_bytes.as_slice(),
//         message.as_slice(),
//         signature.as_slice(),
//         recovery_id,
//     )
//     .map(|_| ())
// }
// 
// fn diffie_hellman_k256(
//     private_key_bytes: Vec<u8>,
//     public_key_bytes: Vec<u8>,
// ) -> Result<Vec<u8>, String> {
//     k256_helper::diffie_hellman_byte_params(
//         private_key_bytes.as_slice(),
//         public_key_bytes.as_slice(),
//     )
// }

    public static func diffie_hellman_k256(privateKeyBytes: Data, publicKeyBytes: Data) -> Data throws {
        // Make a RustVec from the Data
        let rustVecPrivateKey = rustVecFromData(data: privateKeyBytes)
        let rustVecPublicKey = rustVecFromData(data: publicKeyBytes)
        // Call the Rust diffie_hellman_k256 function to get a RustVec back
        let result = try XMTPRust.diffie_hellman_k256(rustVecPrivateKey, rustVecPublicKey)
        return dataFromRustVec(rustVec: result)
    }

    public static func verify_k256_sha256(publicKeyBytes: Data, message: Data, signature: Data, recoveryId: UInt8) -> Bool throws {
        // Make a RustVec from the Data
        let rustVecPublicKey = rustVecFromData(data: publicKeyBytes)
        let rustVecMessage = rustVecFromData(data: message)
        let rustVecSignature = rustVecFromData(data: signature)
        // Result<(), String> in Rust becomes a throw in Swift and we ignore the return type
        try XMTPRust.verify_k256_sha256(rustVecPublicKey, rustVecMessage, rustVecSignature, recoveryId)
        return true
    }
}

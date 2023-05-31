import XMTPRustSwift

import Foundation

extension RustString: @unchecked Sendable {}
extension RustString: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("XMTP Rust Error: \(self.as_str().toString())", comment: self.as_str().toString())
    }
}

public func create_client<GenericIntoRustString: IntoRustString>(_ host: GenericIntoRustString, _ is_secure: Bool) async throws -> RustClient {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
        let wrapper = Unmanaged<CbWrapper$create_client>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        if rustFnRetVal.is_ok {
            wrapper.cb(.success(RustClient(ptr: rustFnRetVal.ok_or_err!)))
        } else {
            wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
        }
    }

    return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustClient, Error>) in
        let callback = { rustFnRetVal in
            continuation.resume(with: rustFnRetVal)
        }

        let wrapper = CbWrapper$create_client(cb: callback)
        let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

        __swift_bridge__$create_client(wrapperPtr, onComplete, { let rustString = host.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), is_secure)
    })
}
class CbWrapper$create_client {
    var cb: (Result<RustClient, Error>) -> ()

    public init(cb: @escaping (Result<RustClient, Error>) -> ()) {
        self.cb = cb
    }
}
public func sha256(_ data: RustVec<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$sha256({ let val = data; val.isOwned = false; return val.ptr }()))
}
public func keccak256(_ data: RustVec<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$keccak256({ let val = data; val.isOwned = false; return val.ptr }()))
}
public func verify_k256_sha256(_ public_key_bytes: RustVec<UInt8>, _ message: RustVec<UInt8>, _ signature: RustVec<UInt8>, _ recovery_id: UInt8) throws -> RustString {
    try { let val = __swift_bridge__$verify_k256_sha256({ let val = public_key_bytes; val.isOwned = false; return val.ptr }(), { let val = message; val.isOwned = false; return val.ptr }(), { let val = signature; val.isOwned = false; return val.ptr }(), recovery_id); if val.is_ok { return RustString(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}
public func diffie_hellman_k256(_ private_key_bytes: RustVec<UInt8>, _ public_key_bytes: RustVec<UInt8>) throws -> RustVec<UInt8> {
    try { let val = __swift_bridge__$diffie_hellman_k256({ let val = private_key_bytes; val.isOwned = false; return val.ptr }(), { let val = public_key_bytes; val.isOwned = false; return val.ptr }()); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}
public func public_key_from_private_key_k256(_ private_key_bytes: RustVec<UInt8>) throws -> RustVec<UInt8> {
    try { let val = __swift_bridge__$public_key_from_private_key_k256({ let val = private_key_bytes; val.isOwned = false; return val.ptr }()); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}
public func recover_public_key_k256_sha256(_ message: RustVec<UInt8>, _ signature: RustVec<UInt8>) throws -> RustVec<UInt8> {
    try { let val = __swift_bridge__$recover_public_key_k256_sha256({ let val = message; val.isOwned = false; return val.ptr }(), { let val = signature; val.isOwned = false; return val.ptr }()); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}
public func recover_public_key_k256_keccak256(_ message: RustVec<UInt8>, _ signature: RustVec<UInt8>) throws -> RustVec<UInt8> {
    try { let val = __swift_bridge__$recover_public_key_k256_keccak256({ let val = message; val.isOwned = false; return val.ptr }(), { let val = signature; val.isOwned = false; return val.ptr }()); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}

public class RustSubscription: RustSubscriptionRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$RustSubscription$_free(ptr)
        }
    }
}
public class RustSubscriptionRefMut: RustSubscriptionRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
extension RustSubscriptionRefMut {
    public func close() {
        __swift_bridge__$RustSubscription$close(ptr)
    }
}
public class RustSubscriptionRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension RustSubscriptionRef {
    public func get_envelopes_as_query_response() throws -> RustVec<UInt8> {
        try { let val = __swift_bridge__$RustSubscription$get_envelopes_as_query_response(ptr); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
    }
}
extension RustSubscription: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_RustSubscription$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_RustSubscription$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: RustSubscription) {
        __swift_bridge__$Vec_RustSubscription$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_RustSubscription$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (RustSubscription(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustSubscriptionRef> {
        let pointer = __swift_bridge__$Vec_RustSubscription$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustSubscriptionRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustSubscriptionRefMut> {
        let pointer = __swift_bridge__$Vec_RustSubscription$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustSubscriptionRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_RustSubscription$len(vecPtr)
    }
}


public class RustClient: RustClientRefMut {
    var isOwned: Bool = true

    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }

    deinit {
        if isOwned {
            __swift_bridge__$RustClient$_free(ptr)
        }
    }
}
public class RustClientRefMut: RustClientRef {
    public override init(ptr: UnsafeMutableRawPointer) {
        super.init(ptr: ptr)
    }
}
extension RustClientRefMut {
    public func batch_query(_ req: RustVec<UInt8>) async throws -> RustVec<UInt8> {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$RustClient$batch_query>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustVec<UInt8>(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustVec<UInt8>, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$RustClient$batch_query(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$RustClient$batch_query(wrapperPtr, onComplete, ptr, { let val = req; val.isOwned = false; return val.ptr }())
        })
    }
    class CbWrapper$RustClient$batch_query {
        var cb: (Result<RustVec<UInt8>, Error>) -> ()
    
        public init(cb: @escaping (Result<RustVec<UInt8>, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func query(_ req: RustVec<UInt8>) async throws -> RustVec<UInt8> {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$RustClient$query>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustVec<UInt8>(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustVec<UInt8>, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$RustClient$query(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$RustClient$query(wrapperPtr, onComplete, ptr, { let val = req; val.isOwned = false; return val.ptr }())
        })
    }
    class CbWrapper$RustClient$query {
        var cb: (Result<RustVec<UInt8>, Error>) -> ()
    
        public init(cb: @escaping (Result<RustVec<UInt8>, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func publish<GenericIntoRustString: IntoRustString>(_ token: GenericIntoRustString, _ req: RustVec<UInt8>) async throws -> RustVec<UInt8> {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$RustClient$publish>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustVec<UInt8>(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustVec<UInt8>, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$RustClient$publish(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$RustClient$publish(wrapperPtr, onComplete, ptr, { let rustString = token.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let val = req; val.isOwned = false; return val.ptr }())
        })
    }
    class CbWrapper$RustClient$publish {
        var cb: (Result<RustVec<UInt8>, Error>) -> ()
    
        public init(cb: @escaping (Result<RustVec<UInt8>, Error>) -> ()) {
            self.cb = cb
        }
    }

    public func subscribe(_ req: RustVec<UInt8>) async throws -> RustSubscription {
        func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __private__ResultPtrAndPtr) {
            let wrapper = Unmanaged<CbWrapper$RustClient$subscribe>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
            if rustFnRetVal.is_ok {
                wrapper.cb(.success(RustSubscription(ptr: rustFnRetVal.ok_or_err!)))
            } else {
                wrapper.cb(.failure(RustString(ptr: rustFnRetVal.ok_or_err!)))
            }
        }

        return try await withCheckedThrowingContinuation({ (continuation: CheckedContinuation<RustSubscription, Error>) in
            let callback = { rustFnRetVal in
                continuation.resume(with: rustFnRetVal)
            }

            let wrapper = CbWrapper$RustClient$subscribe(cb: callback)
            let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

            __swift_bridge__$RustClient$subscribe(wrapperPtr, onComplete, ptr, { let val = req; val.isOwned = false; return val.ptr }())
        })
    }
    class CbWrapper$RustClient$subscribe {
        var cb: (Result<RustSubscription, Error>) -> ()
    
        public init(cb: @escaping (Result<RustSubscription, Error>) -> ()) {
            self.cb = cb
        }
    }
}
public class RustClientRef {
    var ptr: UnsafeMutableRawPointer

    public init(ptr: UnsafeMutableRawPointer) {
        self.ptr = ptr
    }
}
extension RustClient: Vectorizable {
    public static func vecOfSelfNew() -> UnsafeMutableRawPointer {
        __swift_bridge__$Vec_RustClient$new()
    }

    public static func vecOfSelfFree(vecPtr: UnsafeMutableRawPointer) {
        __swift_bridge__$Vec_RustClient$drop(vecPtr)
    }

    public static func vecOfSelfPush(vecPtr: UnsafeMutableRawPointer, value: RustClient) {
        __swift_bridge__$Vec_RustClient$push(vecPtr, {value.isOwned = false; return value.ptr;}())
    }

    public static func vecOfSelfPop(vecPtr: UnsafeMutableRawPointer) -> Optional<Self> {
        let pointer = __swift_bridge__$Vec_RustClient$pop(vecPtr)
        if pointer == nil {
            return nil
        } else {
            return (RustClient(ptr: pointer!) as! Self)
        }
    }

    public static func vecOfSelfGet(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustClientRef> {
        let pointer = __swift_bridge__$Vec_RustClient$get(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustClientRef(ptr: pointer!)
        }
    }

    public static func vecOfSelfGetMut(vecPtr: UnsafeMutableRawPointer, index: UInt) -> Optional<RustClientRefMut> {
        let pointer = __swift_bridge__$Vec_RustClient$get_mut(vecPtr, index)
        if pointer == nil {
            return nil
        } else {
            return RustClientRefMut(ptr: pointer!)
        }
    }

    public static func vecOfSelfLen(vecPtr: UnsafeMutableRawPointer) -> UInt {
        __swift_bridge__$Vec_RustClient$len(vecPtr)
    }
}




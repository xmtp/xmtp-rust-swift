public func query<GenericIntoRustString: IntoRustString>(_ host: GenericIntoRustString, _ topic: GenericIntoRustString, _ json_paging_info: GenericIntoRustString) async -> ResponseJson {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResponseJson) {
        let wrapper = Unmanaged<CbWrapper$query>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        wrapper.cb(.success(rustFnRetVal.intoSwiftRepr()))
    }

    return await withCheckedContinuation({ (continuation: CheckedContinuation<ResponseJson, Never>) in
        let callback = { rustFnRetVal in
            continuation.resume(with: rustFnRetVal)
        }

        let wrapper = CbWrapper$query(cb: callback)
        let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

        __swift_bridge__$query(wrapperPtr, onComplete, { let rustString = host.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = topic.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = json_paging_info.intoRustString(); rustString.isOwned = false; return rustString.ptr }())
    })
}
class CbWrapper$query {
    var cb: (Result<ResponseJson, Never>) -> ()

    public init(cb: @escaping (Result<ResponseJson, Never>) -> ()) {
        self.cb = cb
    }
}
public func publish<GenericIntoRustString: IntoRustString>(_ host: GenericIntoRustString, _ token: GenericIntoRustString, _ json_envelopes: RustVec<GenericIntoRustString>) async -> ResponseJson {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResponseJson) {
        let wrapper = Unmanaged<CbWrapper$publish>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        wrapper.cb(.success(rustFnRetVal.intoSwiftRepr()))
    }

    return await withCheckedContinuation({ (continuation: CheckedContinuation<ResponseJson, Never>) in
        let callback = { rustFnRetVal in
            continuation.resume(with: rustFnRetVal)
        }

        let wrapper = CbWrapper$publish(cb: callback)
        let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

        __swift_bridge__$publish(wrapperPtr, onComplete, { let rustString = host.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let rustString = token.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let val = json_envelopes; val.isOwned = false; return val.ptr }())
    })
}
class CbWrapper$publish {
    var cb: (Result<ResponseJson, Never>) -> ()

    public init(cb: @escaping (Result<ResponseJson, Never>) -> ()) {
        self.cb = cb
    }
}
public func subscribe_once<GenericIntoRustString: IntoRustString>(_ host: GenericIntoRustString, _ topics: RustVec<GenericIntoRustString>) async -> ResponseJson {
    func onComplete(cbWrapperPtr: UnsafeMutableRawPointer?, rustFnRetVal: __swift_bridge__$ResponseJson) {
        let wrapper = Unmanaged<CbWrapper$subscribe_once>.fromOpaque(cbWrapperPtr!).takeRetainedValue()
        wrapper.cb(.success(rustFnRetVal.intoSwiftRepr()))
    }

    return await withCheckedContinuation({ (continuation: CheckedContinuation<ResponseJson, Never>) in
        let callback = { rustFnRetVal in
            continuation.resume(with: rustFnRetVal)
        }

        let wrapper = CbWrapper$subscribe_once(cb: callback)
        let wrapperPtr = Unmanaged.passRetained(wrapper).toOpaque()

        __swift_bridge__$subscribe_once(wrapperPtr, onComplete, { let rustString = host.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), { let val = topics; val.isOwned = false; return val.ptr }())
    })
}
class CbWrapper$subscribe_once {
    var cb: (Result<ResponseJson, Never>) -> ()

    public init(cb: @escaping (Result<ResponseJson, Never>) -> ()) {
        self.cb = cb
    }
}
public func sha256(_ data: RustVec<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$sha256({ let val = data; val.isOwned = false; return val.ptr }()))
}
public func keccak256(_ data: RustVec<UInt8>) -> RustVec<UInt8> {
    RustVec(ptr: __swift_bridge__$keccak256({ let val = data; val.isOwned = false; return val.ptr }()))
}
public func verify_k256_sha256(_ public_key_bytes: RustVec<UInt8>, _ message: RustVec<UInt8>, _ signature: RustVec<UInt8>, _ recovery_id: UInt8) throws -> () {
    try { let val = __swift_bridge__$verify_k256_sha256({ let val = public_key_bytes; val.isOwned = false; return val.ptr }(), { let val = message; val.isOwned = false; return val.ptr }(), { let val = signature; val.isOwned = false; return val.ptr }(), recovery_id); if val.is_ok { return  } else { throw RustString(ptr: val.err!) } }()
}
public func diffie_hellman_k256(_ private_key_bytes: RustVec<UInt8>, _ public_key_bytes: RustVec<UInt8>) throws -> RustVec<UInt8> {
    try { let val = __swift_bridge__$diffie_hellman_k256({ let val = private_key_bytes; val.isOwned = false; return val.ptr }(), { let val = public_key_bytes; val.isOwned = false; return val.ptr }()); if val.is_ok { return RustVec(ptr: val.ok_or_err!) } else { throw RustString(ptr: val.ok_or_err!) } }()
}
public struct ResponseJson {
    public var error: RustString
    public var json: RustString

    public init(error: RustString,json: RustString) {
        self.error = error
        self.json = json
    }

    @inline(__always)
    func intoFfiRepr() -> __swift_bridge__$ResponseJson {
        { let val = self; return __swift_bridge__$ResponseJson(error: { let rustString = val.error.intoRustString(); rustString.isOwned = false; return rustString.ptr }(), json: { let rustString = val.json.intoRustString(); rustString.isOwned = false; return rustString.ptr }()); }()
    }
}
extension __swift_bridge__$ResponseJson {
    @inline(__always)
    func intoSwiftRepr() -> ResponseJson {
        { let val = self; return ResponseJson(error: RustString(ptr: val.error), json: RustString(ptr: val.json)); }()
    }
}
extension __swift_bridge__$Option$ResponseJson {
    @inline(__always)
    func intoSwiftRepr() -> Optional<ResponseJson> {
        if self.is_some {
            return self.val.intoSwiftRepr()
        } else {
            return nil
        }
    }

    @inline(__always)
    static func fromSwiftRepr(_ val: Optional<ResponseJson>) -> __swift_bridge__$Option$ResponseJson {
        if let v = val {
            return __swift_bridge__$Option$ResponseJson(is_some: true, val: v.intoFfiRepr())
        } else {
            return __swift_bridge__$Option$ResponseJson(is_some: false, val: __swift_bridge__$ResponseJson())
        }
    }
}



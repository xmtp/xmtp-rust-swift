//
//  ApiService.swift
//  
//
//  Created by Michael Xu on 4/14/23.
//

import Foundation

// The goal of this class is to provide a steady-ish Swift interface between Rust and xmtp-ios
public class ApiService {
    static let shared = ApiService()
    
    let environment: String
    let secure: Bool
    
    public init(environment: String = "https://dev.xmtp.network", secure: Bool = true) {
        self.environment = environment
        self.secure = secure
    }

    // shared getter
    public static func get() -> ApiService {
        return ApiService.shared
    }
    
    // It's all strings all the time
    public func query(topic: String, json_paging_info: String) async throws -> String {
        // Call XMTPRust.query_serialized with the given parameters, expect a XMTPRust.ResponseJson object
        // that has { error: String, json: String }
        let response: ResponseJson = await XMTPRust.query(self.environment.intoRustString(), topic.intoRustString(), json_paging_info.intoRustString())
        
        // If the error is not an empty string
        if response.error.toString() != "" {
            throw NSError(domain: "XMTPRust", code: 0, userInfo: [NSLocalizedDescriptionKey: response.error.toString()])
        }
        
        return response.json.toString()
    }

    // Publishes a string, which better be an encoded Xmtp_MessageApi_V1_PublishRequest with envelopes provided
    public func publish(token: String, envelopes: String) async throws -> String {
        // Call XMTPRust.publish_serialized with the given parameters, expect a XMTPRust.ResponseJson object
        // that has { error: String, json: String }
        let response: ResponseJson = await XMTPRust.publish(self.environment.intoRustString(), token.intoRustString(), envelopes.intoRustString())
        
        // If the error is not an empty string
        if response.error.toString() != "" {
            throw NSError(domain: "XMTPRust", code: 0, userInfo: [NSLocalizedDescriptionKey: response.error.toString()])
        }
        
        return response.json.toString()
    }

//    // Subscribe, we need to fake an AsyncThrowingStream by cleverly using a DispatchQueue and repeatedly
//    // calling an async function that will call XMTPRust.subscribe_serialized and return a string
//    // that better be an encoded Xmtp_MessageApi_V1_SubscribeResponse with envelopes provided
//    func subscribe(topics: [String]) -> AsyncThrowingStream<String, Error> {
//        return AsyncThrowingStream { continuation in
//            // Create a DispatchQueue
//            let queue = DispatchQueue(label: "XMTPRust.subscribe_serialized")
//            
//            // Create a timer that will call the async function every 1 second
//            let timer = DispatchSource.makeTimerSource(queue: queue)
//            timer.schedule(deadline: .now(), repeating: .seconds(1))
//            timer.setEventHandler {
//                Task {
//                    // Call XMTPRust.subscribe_serialized with the given parameters, expect a String
//                    // that better be an encoded Xmtp_MessageApi_V1_SubscribeResponse with envelopes provided
//                    let response = try await XMTPRust.subscribe_serialized(topics)
//
//                    // If the error is not an empty string
//                    if response.error != "" {
//                        continuation.finish(throwing: NSError(domain: "XMTPRust", code: 0, userInfo: [NSLocalizedDescriptionKey: response.error]))
//                    }
//
//                    // Yield the response
//                    continuation.yield(response.json)
//                }
//            }
//            
//            // Start the timer
//            timer.resume()
//            
//            // Return a closure that will cancel the timer
//            return {
//                timer.cancel()
//            }
//        }
//    }
}

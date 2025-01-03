// The Swift Programming Language
// https://docs.swift.org/swift-book

import os
import Foundation


/// A logging utility to standardize debug, info, error, and warning logs.
///
/// The `Timber` struct is a wrapper around Apple's `Logger` API, designed to make
/// logging consistent and easy to use throughout the application. It utilizes
/// conditional compilation to ensure logs are only produced in debug builds.
/**
 *Usage
 *Timber.i("Log message here") - For Logging Info Logs
 *Timber.d("Log message here") - For Logging Debug Logs
 *Timber.w("Log message here") - For Logging Warning Logs
 *Timber.e("Log message here") - For Logging Error Logs
 */

struct Timber {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.logger.timber"
    private static let logger = Logger(subsystem: subsystem, category: "logging")
    
    static func d(_ message: String) {
        #if DEBUG
        logger.debug("Debug: \(message, privacy: .private)")
        #endif
    }
    
    static func i(_ message: String) {
        #if DEBUG
        logger.info("Info: \(message, privacy: .private)")
        #endif
    }
    
    static func e(_ message: String) {
        #if DEBUG
        logger.error("Error: \(message, privacy: .private)")
        #endif
    }
    
    static func w(_ message: String) {
        #if DEBUG
        logger.info("Warning: \(message, privacy: .private)")
        #endif
    }
}

/**
 *The various levels of logging available
 *debug
 *info
 *error
 *warning
 */
enum LoggingLevel: String {
    case debug
    case info
    case error
    case warning
}

func networkLogger(_ request: URLRequest, response: HTTPURLResponse?, data: Data?) {
    let networkLogger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "com.logger.timber.network", category: "network")
#if DEBUG
    networkLogger.info("Request: \(request.url?.absoluteString ?? "Unknown URL", privacy: .public)")
    networkLogger.info("Method: \(request.httpMethod ?? "Unknown method", privacy: .public)")
    networkLogger.info("Headers: \(request.allHTTPHeaderFields?.description ?? "No headers", privacy: .private)")
    
    if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
        networkLogger.debug("Request Body: \(bodyString, privacy: .private)")
    }
    
    networkLogger.info("Status Code: \(response?.statusCode ?? 0, privacy: .public)")
    
    if let data = data {
        let responseSize = ByteCountFormatter.string(fromByteCount: Int64(data.count), countStyle: .file)
        networkLogger.info("Response Size: \(responseSize, privacy: .public)")
        
        if let responseString = String(data: data, encoding: .utf8) {
            networkLogger.debug("Response Body: \(responseString, privacy: .private)")
        }
    }
#endif
}

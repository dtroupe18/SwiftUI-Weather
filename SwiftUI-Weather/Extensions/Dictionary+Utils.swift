//
//  Dictionary+Utils.swift
//  SwiftUI-Weather
//
//  Created by Dave Troupe on 8/4/19.
//  Copyright © 2019 HighTreeDevelopment. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Returns Dictionary with pretty printed JSON
    /// - warning: returns "invalid JSON" is JSON is not properly formated
    var asJSON: String {
        let invalidJson = "invalid JSON"
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? invalidJson
        } catch {
            return invalidJson
        }
    }
}

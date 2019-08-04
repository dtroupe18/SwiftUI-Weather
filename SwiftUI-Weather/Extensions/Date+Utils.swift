//
//  Date+Utils.swift
//  SwiftUI-Weather
//
//  Created by Dave Troupe on 8/4/19.
//  Copyright © 2019 HighTreeDevelopment. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSinceEpoch: Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}

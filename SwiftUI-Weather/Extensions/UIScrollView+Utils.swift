//
//  UIScrollView+Utils.swift
//  SwiftUI-Weather
//
//  Created by Dave Troupe on 8/4/19.
//  Copyright © 2019 HighTreeDevelopment. All rights reserved.
//

import UIKit

extension UIScrollView {
    // Resets content offset to (0, 0)
    func resetScrollPositionToTop() {
        self.contentOffset = CGPoint(x: -contentInset.left, y: -contentInset.top)
    }
}

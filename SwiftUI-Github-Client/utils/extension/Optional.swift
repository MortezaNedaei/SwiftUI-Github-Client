//
//  Optional.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/17/1399 AP.
//

import Foundation

extension Optional where Wrapped == Int {
    
    func toString() -> String {
        return "\(self ?? 0)"
    }
    
}

//
//  Cardify.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    var width: CGFloat = 150
    var height: CGFloat = 100
    
    func body(content: Content) -> some View {
        ZStack {
            CardView(width: width, height: height)
            content
        }
    }
    
}

extension View {
    func cardify(width: CGFloat = 150, height: CGFloat = 100) -> some View {
        return self.modifier(Cardify(width: width, height: height))
    }
}


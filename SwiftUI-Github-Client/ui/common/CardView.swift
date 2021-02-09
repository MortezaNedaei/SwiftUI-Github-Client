//
//  CardView.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import SwiftUI

struct CardView: View {
    
    var width: CGFloat = 150
    var height: CGFloat = 100
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16.0)
            .foregroundColor(.white)
            //.aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: .center)
            .shadow(radius: 0.75)
            .padding(2)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}

//
//  CircleImageView.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import SwiftUI

struct CircleImageView: View {
    
    var imgUrl: String?
    var size: CGFloat = 48.0
    
    var body: some View {
        
        if let url = URL(string: imgUrl!) {
            AsyncImage(
                url: url,
                placeholder: {
                    Circle().foregroundColor(.gray).opacity(0.25)
                },
                image: { Image(uiImage: $0).resizable() }
            )
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
        }
        
        
        //        Image(systemName: img)
        //            .resizable()
        //            .frame(width: size, height: size)
        //            .clipShape(Circle())
        //            .overlay(Circle().stroke(Color.white, lineWidth: 2))
        //            .shadow(radius: 5)
        
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}

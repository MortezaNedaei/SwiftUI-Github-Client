//
//  HorizontalList.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import SwiftUI

struct HorizontalList<Content: View> : View {
    
    //// View
    let content: (RepositoryResponse) -> Content
    
    // Data
    let selection : [RepositoryResponse]
    
    init(_ selection: [RepositoryResponse], @ViewBuilder content: @escaping (RepositoryResponse) -> Content) {
        self.content = content
        self.selection = selection
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
            HStack(spacing: 5) {
                ForEach(selection, id: \.self) { repository in
                    content(repository)
                }
            }
        }
    }
    
    //    RESULT:
    
    //    ScrollView(.horizontal, showsIndicators: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/) {
    //        HStack(spacing: 5) {
    //            ForEach(1..<10) { repository in
    //                CardView()
    //            }
    //        }
    //    }
}

//
//  MyRepositoriesViewModel.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import Foundation

class MyRepositoriesViewModel: ObservableObject {
    
    @Published private(set) var repositories: [RepositoryResponse] = []
    
}

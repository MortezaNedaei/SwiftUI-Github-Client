//
//  OldRepositoriesViewModel.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import Foundation

class OldRepositoriesViewModel: ObservableObject {
    
    @Published private(set) var repositories: [RepositoryResponse] = []
    
    
    init() {
        _ = getOldRepositories()
    }
    
    
    /// get old repositories without any filter
    private func getOldRepositories() -> [RepositoryResponse] {
        
        let url = URL(string: Constants.reposUrl)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode([RepositoryResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.repositories = response
                    }
                    //print("Response................. \(response)")
                } catch let error {
                    print("ERROR..................\n \(error)")
                }
            }
        }.resume()
        
        return []
    }
    
}

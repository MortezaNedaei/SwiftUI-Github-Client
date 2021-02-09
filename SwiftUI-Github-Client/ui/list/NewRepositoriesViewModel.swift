//
//  NewRepositoriesViewModel.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/20/1399 AP.
//

import Foundation

class NewRepositoriesViewModel: ObservableObject {
    
    @Published private(set) var repositories: [RepositoryResponse] = []
    
    
    init() {
        _ = getNewRepositories()
    }
    
    
    ///  get last updated repositories in all github languages
    private func getNewRepositories() -> [RepositoryResponse] {
        
        var components = URLComponents(string: Constants.searchRepoUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "star:>=0"),
            URLQueryItem(name: "sort", value: "updated"),
            URLQueryItem(name: "order", value: "desc")
        ]
        let url = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.repositories = response.items ?? []
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

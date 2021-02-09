//
//  BestRepositoriesViewModel.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/19/1399 AP.
//

import Foundation


class MostStarRepositoriesViewModel: ObservableObject {
    
    @Published private(set) var repositories: [RepositoryResponse] = []
    
    
    let language: String
    init(language: String = "Any") {
        self.language = language
        _ = getMostStarRepositories(language: language)
    }
    
    
    // MARK: get most star repositories (Order by star)
    private func getMostStarRepositories(language: String = "Any") -> [RepositoryResponse] {
        
        var components = URLComponents(string: Constants.mostStarUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "stars:>=1+language:\(language)"),
            URLQueryItem(name: "sort", value: "stars"),
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
    
    
    // MARK: get repositories without any filter
    private func getRepositories() -> [RepositoryResponse] {
        
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


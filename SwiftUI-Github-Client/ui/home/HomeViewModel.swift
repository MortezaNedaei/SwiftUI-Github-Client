//
//  HomeViewModel.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/16/1399 AP.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var newRepositories: [RepositoryResponse] = []
    @Published private(set) var mostStarRepositories: [RepositoryResponse] = []
    @Published private(set) var myRepositories: [RepositoryResponse] = []
    @Published private(set) var oldRepositories: [RepositoryResponse] = []
    
    let perPage = 10.description
    
    
    let language: String
    init(language: String = "Any") {
        self.language = language
        _ = getNewRepositories()
        _ = getMostStarRepositories(language: language)
        _ = getOldRepositories()
    }
    
    
    // MARK: get last updated repositories in all github languages
    private func getNewRepositories() -> [RepositoryResponse] {
        
        var components = URLComponents(string: Constants.searchRepoUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "star:>=0"),
            URLQueryItem(name: "sort", value: "updated"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "per_page", value: perPage)
        ]
        let url = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.newRepositories = response.items ?? []
                    }
                    //print("Response................. \(response)")
                } catch let error {
                    print("ERROR..................\n \(error)")
                }
            }
        }.resume()
        
        return []
    }
    
    // MARK: get most star repositories (Order by star)
    private func getMostStarRepositories(language: String = "Any") -> [RepositoryResponse] {
        
        var components = URLComponents(string: Constants.mostStarUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "stars:>=1+language:\(language)"),
            URLQueryItem(name: "sort", value: "stars"),
            URLQueryItem(name: "order", value: "desc"),
            URLQueryItem(name: "per_page", value: perPage)
        ]
        let url = URLRequest(url: components.url!)
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode(SearchRepositoryResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.mostStarRepositories = response.items ?? []
                    }
                    //print("Response................. \(response)")
                } catch let error {
                    print("ERROR..................\n \(error)")
                }
            }
        }.resume()
        
        return []
    }
    
    
    // MARK: get old repositories without any filter
    private func getOldRepositories() -> [RepositoryResponse] {
        
        let url = URL(string: Constants.reposUrl)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                guard let data = data else { return }
                do {
                    let response = try JSONDecoder().decode([RepositoryResponse].self, from: data)
                    DispatchQueue.main.async {
                        self.oldRepositories = response
                    }
                    //print("Response................. \(response)")
                } catch let error {
                    print("ERROR..................\n \(error)")
                }
            }
        }.resume()
        
        return []
    }
    
    // MARK: get last updated repositories by language
    private func getNewRepositoriesByLanguage(for language: String = "Any") -> [RepositoryResponse] {
        
        var components = URLComponents(string: Constants.searchRepoUrl)!
        components.queryItems = [
            URLQueryItem(name: "q", value: "language:\(language)"),
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
                        self.newRepositories = response.items ?? []
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

//
//  Constants.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/17/1399 AP.
//

import Foundation


struct Constants {
    
    // End Points
    static let baseUrl = "https://api.github.com/"
    static let reposUrl = baseUrl + "repositories"
    static let searchRepoUrl = baseUrl + "search/repositories"
    static let mostStarUrl = baseUrl + "search/repositories?q=stars=1+language:Java&sort=stars&order=desc"
    static let newUpdatedRepositoriesByLanguage = searchRepoUrl + "?q=language:kotlin&sort=updated&order=desc"
    
    
    static let LANGUAGES_FILE_NAME = "languages"
    
}

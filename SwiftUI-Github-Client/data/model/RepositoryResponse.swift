//
//  TrendingResponse.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/16/1399 AP.
//

import Foundation

struct RepositoryResponse: Decodable, Identifiable, Hashable {
    var id: Int
    var name: String? = ""
    var full_name: String? = ""
    var description: String? = ""
    var owner: OwnerResponse?
    var stargazers_count: Int? = 0
    var forks: Int? = 0
    var watchers: Int? = 0
    var language: String? = ""
    var html_url: String? = ""
}

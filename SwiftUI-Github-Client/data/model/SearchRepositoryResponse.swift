//
//  SearchResponse.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/17/1399 AP.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    var total_count: Int? = 0
    var incomplete_results: Bool? = false
    var items: [RepositoryResponse]?
}

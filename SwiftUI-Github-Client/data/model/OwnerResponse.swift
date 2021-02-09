//
//  OwnerResponse.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/17/1399 AP.
//

import Foundation

struct OwnerResponse: Decodable, Identifiable, Hashable {
    var id: Int
    var login: String? = ""
    var avatar_url: String? = ""
}

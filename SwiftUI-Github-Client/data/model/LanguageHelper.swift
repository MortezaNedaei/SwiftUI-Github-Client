//
//  LanguageHelper.swift
//  SwiftUI-Github-Client
//
//  Created by MoNe on 11/17/1399 AP.
//

import Foundation

//let json =
//    """
//{
//    "JavaScript": {
//        "color": "#f1e05a",
//        "url": "https://github.com/trending?l=JavaScript"
//    },
//    "C++": {
//        "color": "#f34b7d",
//        "url": "https://github.com/trending?l=C++"
//    }
//}
//""".data(using: .utf8)!

struct Language : Codable {
    var url: String? = ""
    var color: String? = "#ffffff"
}

func parseJson(fileName: String, languageKey: String = "") -> Language? {
    do {
        let json = readLocalFile(forName: fileName)!
        let languageData = try JSONDecoder().decode([String : Language].self, from: json)
        return languageData[languageKey]
    } catch {
        print("error:\(error)")
    }
    
    return nil
}

func readLocalFile(forName name: String) -> Data? {
    do {
        if let bundlePath = Bundle.main.path(forResource: name,
                                             ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
            return jsonData
        }
    } catch {
        print(error)
    }
    
    return nil
}

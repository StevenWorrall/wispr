//
//  TypeaceModel.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import Foundation

struct TypefaceModel: Codable {
    let name: String
    let conversionTable: [String: String]

    func convert(_ text: String) -> String {
        return String(text.map { Character(conversionTable[String($0)] ?? String($0)) })
    }
    
    var fancyName: String {
        get {
            return self.convert(name)
        }
    }
}

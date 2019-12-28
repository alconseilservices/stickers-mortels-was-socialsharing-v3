//
//  Pack.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 27/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import Foundation
import SwiftUI

struct Pack: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var size: String
    var iconName: String
    var dataFileName: String
    var stickersNames: [String]
}

final class PackStore {
    
    var packs: [Pack] = []
    
    init() {
        fetch()
    }

    private func fetch() {
        packs = loadFromBundle("packs")
        print("data fetch with success")
    }
    
    private func loadFromBundle(_ filename: String) -> [Pack] {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
            return parse(data)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
    }
    
    private func parse(_ data: Data) -> [Pack] {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([Pack].self, from: data)
        } catch {
            fatalError("Couldn't parse data:\n\(error)")
        }
    }
}

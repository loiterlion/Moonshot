//
//  Bundle-Decodable.swift
//  MoonShot
//
//  Created by Bruce Wang on 2023/12/18.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(_ file: String) -> T {
        guard let url = url(forResource: file, withExtension: nil)else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file \(file)")
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let decoded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode file \(file)")
        }
                       
        return decoded
    }
}

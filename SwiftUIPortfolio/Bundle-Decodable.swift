//
//  Bundle-Decodable.swift
//  SwiftUIPortfolio
//
//  Created by Sarp  on 3.12.2022.
//

import Foundation

extension Bundle {
    func decode<T: Decodable>(
        _ type: T.Type,
        from file: String,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys)
    -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: nil) else {
            fatalError()
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(type, from: data)
        } catch {
            fatalError()
        }
    }
}

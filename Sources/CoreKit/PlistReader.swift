//
//  PlistReader.swift
//  CoreKit
//
//  Created by Miguel Solans on 28/03/2026.
//

import Foundation

public struct PlistReader {
    
    static func value<T>(forKey key: String) -> T? {
        return Bundle.main.object(forInfoDictionaryKey: key) as? T
    }
}

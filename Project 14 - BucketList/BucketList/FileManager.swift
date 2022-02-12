//
//  FileManager.swift
//  BucketList
//
//  Created by Can Bi on 12.02.2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

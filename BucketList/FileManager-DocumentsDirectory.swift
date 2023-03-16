//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Md. Masud Rana on 2/25/23.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

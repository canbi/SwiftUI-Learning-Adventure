//
//  LocalFileManager.swift
//  SomeoneNew
//
//  Created by Nick Sarno on 4/22/21.
//  Swiftful Thinking https://youtu.be/Yiq-hdhLzVM
//
//  Updated by Can Bi on 15.02.2022.
//

import Foundation
import SwiftUI

class LocalFileManager: ObservableObject {
    let folderName = "MyApp_Images"
    var appFolder = FileManager.SearchPathDirectory.documentDirectory
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let path = FileManager
                .default
                .urls(for: appFolder, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
                    return
                }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard let path = FileManager
                .default
                .urls(for: appFolder, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .path else {
                    return
                }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder. \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 0.8),
            let path = getPathForImage(name: name) else {
                return "Error getting data."
            }
        
        do {
            try data.write(to: path,options: [.atomic, .completeFileProtection])
            return "Success saving!"
        } catch let error {
            return "Error saving. \(error)"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
                  print("Error getting path.")
                  return nil
              }
        
        return UIImage(contentsOfFile: path)
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name)?.path,
              FileManager.default.fileExists(atPath: path) else {
                  return "Error getting path."
              }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Sucessfully deleted."
        } catch let error {
            return "Error deleting image. \(error)"
        }
        
    }
    
    
    func getPathForImage(name: String) -> URL? {
        guard let path = FileManager
                .default
                .urls(for: appFolder, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpg") else {
                    print("Error getting path.")
                    return nil
                }
        return path
    }
}

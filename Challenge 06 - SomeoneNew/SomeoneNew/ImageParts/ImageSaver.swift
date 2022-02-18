//
//  ImageSaver.swift
//  SomeoneNew
//
//  Created by Paul Hudson on 02/12/2021.
//  Updated by Can Bi on 15/02/2022.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        //UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}

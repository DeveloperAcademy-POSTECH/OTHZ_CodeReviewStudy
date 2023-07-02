//
//  ImageFileManager.swift
//  HeckDesigns
//
//  Created by Seungui Moon on 2023/06/21.
//

import SwiftUI

class ImageFileManager {
    static let shared: ImageFileManager = ImageFileManager()
    
    func saveImage(image: UIImage, name: String, onSuccess: @escaping ((Bool) -> Void)) {
        guard let data: Data = image.jpegData(compressionQuality: 1) ?? image.pngData(),
        let directory: NSURL = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false) as NSURL else {
            return
        }
        
        do {
            try data.write(to: directory.appendingPathComponent(name)!)
            onSuccess(true)
        } catch {
            onSuccess(false)
        }
    }
    
    func getSavedImage(named: String) -> UIImage? {
        guard let dir: URL = try? FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false) else {
            return nil
        }
        
        let path: String = URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path
        let image: UIImage? = UIImage(contentsOfFile: path)
        
        return image
    }
    
    func deleteImage(named: String,
                     onSuccess: @escaping ((Bool) -> Void)) {
      guard let directory =
            try? FileManager.default.url(for: .documentDirectory,
                                         in: .userDomainMask,
                                         appropriateFor: nil,
                                         create: false) as NSURL,
            let docuPath = directory.path
      else { return }
        
      do {
            let fileNames = try FileManager.default.contentsOfDirectory(atPath: docuPath)
            
            for fileName in fileNames {
                if fileName == named {
                    let filePathName = "\(docuPath)/\(fileName)"
                    try FileManager.default.removeItem(atPath: filePathName)
                    onSuccess(true)
                    return
                }
            }
      } catch {
            onSuccess(false)
      }
    }
}

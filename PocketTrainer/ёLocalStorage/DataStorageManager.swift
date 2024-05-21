//
//  DataStorageManager.swift
//  PocketTrainer
//
//  Created by Arseni Khatsuk on 20.05.2024.
//

import Foundation
import UIKit

class DataManager {
    
    static let shared = DataManager()
    private init() {}
    
    func saveTrainingsLocally(trainings: [Training]) {
        if let encoded = try? JSONEncoder().encode(trainings) {
            UserDefaults.standard.set(encoded, forKey: "savedTrainings")
        }
    }
    
    func loadTrainingsLocally() -> [Training]? {
        guard let savedTrainings = UserDefaults.standard.data(forKey: "savedTrainings") else {
            return nil
        }
        do {
            let trainings = try JSONDecoder().decode([Training].self, from: savedTrainings)
            return trainings
        } catch {
            print("Failed to decode saved trainings: \(error)")
            return nil
        }
    }
    
    func saveImageLocally(image: UIImage, imageName: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            try? imageData.write(to: fileURL)
        }
    }
    
    func loadImageLocally(imageName: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(imageName)
        if let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        }
        return nil
    }
    
    func saveVideoLocally(videoData: Data, videoName: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = documentsDirectory.appendingPathComponent(videoName)
        do {
            try videoData.write(to: fileURL)
        } catch {
            print("Failed to save video locally: \(error)")
        }
    }
    
    func loadVideoLocally(videoName: String) -> Data? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(videoName)
        if let videoData = try? Data(contentsOf: fileURL) {
            return videoData
        }
        return nil
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func downloadVideo(from url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data)
        }
        task.resume()
    }
}

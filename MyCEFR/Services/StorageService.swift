//
//  StorageService.swift
//  MyCEFR
//
//  Created by Лаборатория on 07.06.2023.
//

import UIKit
import FirebaseStorage

enum ErrorsStorage: Error {
    case dataNil
    case imageNil
}

class StorageService {

    static let shared = StorageService()
    let store = Storage.storage()
    var storeRef: StorageReference { store.reference() }

    private init() { }
    
    func getImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> ()) {
        let imageRef = storeRef.child(imageUrl)
        imageRef.getData(maxSize: 2000000) { data, error in
            if let error {
                completion(.failure(error))
            } else {
                if let data {
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    } else {
                        completion(.failure(ErrorsStorage.imageNil))
                    }
                } else {
                    completion(.failure(ErrorsStorage.dataNil))
                }
            }
        }
    }

    func uploadPhotos(image: Data, imageUrl: String, completion: @escaping () -> (), completionProgress: @escaping (Double) -> ()) {
        let data = image
        let riversRef = storeRef.child(imageUrl)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = riversRef.putData(data, metadata: metadata) {_ in
            completion()
        }
        uploadTask.observe(.progress) { snapshot in
            if let progress = snapshot.progress?.fractionCompleted {
                completionProgress(progress)
            }
        }
    }

}

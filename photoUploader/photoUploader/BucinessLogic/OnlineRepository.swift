//
//  OnlineRepository.swift
//  photoUploader
//
//  Created by Yaroslava Hlibochko on 26.11.2019.
//  Copyright © 2019 Yaroslava Hlibochko. All rights reserved.
//

import Foundation
import Alamofire

final class OnlineRepository {
    
    private let dispatchQueue = DispatchQueue(label: "myQueue", qos: .background)
    private let semaphore = DispatchSemaphore(value: 0)

    
    func uploadPhoto(data: Data, name: String, completionHandler: @escaping (([String:Any]?, Error?)->Void)) {
        dispatchQueue.async {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                let mimeType = "jpeg"
                multipartFormData.append(data, withName: "image", fileName: name, mimeType: "image/\(mimeType)")

            }, usingThreshold: UInt64.init(), to: "https://api.imgur.com/3/upload", method: .post, headers: ["Content-type": "multipart/form-data", "Authorization" : "Client-ID " + CLIENT_ID]) { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON(completionHandler: { (response) in
                        response.result.ifSuccess {
                            self.semaphore.signal()
                            completionHandler(response.result.value as? [String : Any], nil)
                        }
                        response.result.ifFailure {
                            self.semaphore.signal()
                            completionHandler(nil, response.error)
                        }
                    })
                case .failure(let encodingError):
                    self.semaphore.signal()
                    completionHandler(nil, encodingError)
                }
            }
            self.semaphore.wait()
        }
    }
}


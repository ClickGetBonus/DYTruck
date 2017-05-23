//
//  UploadImageApi.swift
//  DYTruck
//
//  Created by Lan on 2017/5/22.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import YTKNetwork
import AFNetworking

class UploadImageApi: DYBaseRequest, DYRequest {
    
    typealias Response = UploadImageResponse
    
    var images: [UIImage]
    
    init(images: [UIImage]) {
        self.images = images
        super.init()
        
        self.constructingBodyBlock = { (formData: AFMultipartFormData) in
            for (i, image) in self.images.enumerated() {
                let data = UIImageJPEGRepresentation(image, 1)
                formData.appendPart(withFileData: data!,
                                    name: "`",
                                    fileName: "iamge\(i).jpg", mimeType: "image/jpeg")
            }
        }
    }
    
    
    
    override func requestUrl() -> String {
        return "api/file/upload"
    }
    
    override func requestMethod() -> YTKRequestMethod {
        return .POST
    }
    
}

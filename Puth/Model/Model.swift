//
//  Model.swift
//  Puth
//
//  Created by Zabeehullah Qayumi on 2/3/19.
//  Copyright © 2019 Zabeehullah Qayumi. All rights reserved.
//

import Foundation

class Model {
    let caption: String?
    let photoUrl: String?
    
    init(captionText: String, photoUrlString: String) {
        caption = captionText
        photoUrl = photoUrlString
    }
}

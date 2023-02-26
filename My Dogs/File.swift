//
//  File.swift
//  My Dogs
//
//  Created by 라완 💕 on 11/05/1444 AH.
//

import UIKit

struct imageData: Codable{
    var data: Data
    var uniqueID = UUID().uuidString
}

struct dog {
    var name: String?
    var color: String?
    var food: String?
    var image: imageData
    let uID = UUID().uuidString
    
    
    
}

protocol dogImageProtocol: AnyObject{
    
    //function to send the image data as jpeg data
    func selectedDogImage(selectedDog: DogEntity)
    
}

protocol editingPageDelegate: AnyObject{
    
    func edetingDelegateFunc(dogToDelete: DogEntity, dtStatus: Bool,iP: IndexPath)
    
}

protocol cellDelegate: AnyObject {
    func dogCellTobeUpdated(cellDog: DogEntity,iP: IndexPath)
}

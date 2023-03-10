//
//  DogStruct.swift
//  My Dogs
//
//  Created by λΌμ π on 13/05/1444 AH.
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
    func selectedDogImage(selectedDog: DogEntity)
}

protocol editingPageDelegate: AnyObject{
    func edetingDelegateFunc(dogToDelete: DogEntity, dtStatus: Bool,iP: IndexPath)
}

protocol cellDelegate: AnyObject {
    func dogCellTobeUpdated(cellDog: DogEntity,iP: IndexPath)
}

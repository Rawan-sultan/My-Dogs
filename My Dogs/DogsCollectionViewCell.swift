//
//  DogsCollectionViewCell.swift
//  My Dogs
//
//  Created by 라완 💕 on 08/05/1444 AH.
//

import UIKit

class DogsCollectionViewCell: UICollectionViewCell {
    
    var cellDog: DogEntity?
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var DogimageView: UIImageView!
    
    weak var delegate: cellDelegate?
    var index: IndexPath!
    @IBAction func editingButton(_ sender: UIButton) {
        delegate?.dogCellTobeUpdated(cellDog: cellDog!,iP: index)
    }
    func configDogImage(dogImageData: DogEntity,iP: IndexPath){
        cellDog = dogImageData
        imageButton.setTitle("\(dogImageData.name!)", for: .normal)
        DogimageView.image = UIImage(data: dogImageData.image!)
        index = iP
    }
    }


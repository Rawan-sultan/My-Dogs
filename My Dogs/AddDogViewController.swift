//
//  AdditionViewController.swift
//  My Dogs
//
//  Created by 라완 💕 on 11/05/1444 AH.
//

import UIKit

class AddDogViewController: UIViewController {
    @IBOutlet weak var dogNameField: UITextField!
    @IBOutlet weak var dogColorField: UITextField!
    @IBOutlet weak var dogFoodField: UITextField!
    
    @IBOutlet weak var addDog: UIButton!
    @IBOutlet weak var addImage: UIButton!
    @IBOutlet weak var selectImage: UIImageView!
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dogg = UIImage(named: "dog.jpeg")!
    weak var imageDelegate: dogImageProtocol?
    
    let imageController: UIImagePickerController = UIImagePickerController()
    var userImage: UIImage?{
        didSet {
            getPhoto()
        }
    }
    
    override func viewDidLoad() {
            super.viewDidLoad()
        addImage.setTitle("Add Photo", for: .normal)
        selectImage.image = dogg
        addImage.tintColor = .white
        imageController.delegate = self
        addDog.setTitle("Add Dog", for: .normal)
            // Do any additional setup after loading the view.
        }
    
    @IBAction func addImagePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "Photo library", style: .default){ [weak self] alertAction in
            self?.photoActionClicked()
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
        alert.addAction(photoAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    @IBAction func addDogPressed(_ sender: UIButton) {
        if dogNameField.text == "" || dogColorField.text == "" || dogFoodField.text == "" || userImage == nil {
            let alerController = UIAlertController(title: "Incomplete Data", message: "Please enter All fields and select a photo to add new dog", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alerController.addAction(cancelAction)
            present(alerController, animated: true)
            
        }
        else {
            let newImage = imageData(data: (userImage?.jpegData(compressionQuality: 1.0))!)
            let newDog = dog(name: dogNameField.text, color: dogColorField.text, food: dogFoodField.text, image: newImage)
            let savedDog = DogEntity(context: managedContext)
            savedDog.name = newDog.name
            savedDog.color = newDog.color
            savedDog.favoriteFood = newDog.food
            savedDog.image = newDog.image.data
            imageDelegate?.selectedDogImage(selectedDog: savedDog)
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }
 
    func getPhoto(){
        // just to preview the photo before sendeing
        selectImage.image = userImage
        
    }
}


extension AddDogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            print("no image Found")
            return
        }
        userImage = image
        dismiss(animated: true)
    }

    func photoActionClicked() {
        imageController.sourceType = .photoLibrary
        present(imageController, animated: true)
    }
        
        
    }



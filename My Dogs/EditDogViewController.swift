//
//  EditingViewController.swift
//  My Dogs
//
//  Created by 라완 💕 on 11/05/1444 AH.
//

import UIKit

class EditDogViewController: UIViewController {
    @IBOutlet weak var deleteName: UITextField!
    @IBOutlet weak var deleteColor: UITextField!
    @IBOutlet weak var deleteFood: UITextField!
    
    @IBOutlet weak var editeImage: UIImageView!
    @IBOutlet weak var updateImage: UIButton!
    
    let updateImagePicker: UIImagePickerController = UIImagePickerController()
    weak var updateImageDelegate: editingPageDelegate?
    var index: IndexPath!
    var newDogImage: UIImage?{
        didSet {
            getNewPhoto()
        }
    }
    var dogTobeDeleted: DogEntity!
    override func viewDidLoad() {
        super.viewDidLoad()
        setFields()
        updateImage.setTitle("Change Photo", for: .normal)
        // Do any additional setup after loading the view.
    }
    @objc func doneEdeting(){
        //print("done")
        if deleteName.text == "" || deleteFood.text == "" || deleteColor.text == "" {
            let alerController = UIAlertController(title: "Incomplete Data", message: "Please enter All fields and select a photo to add new dog", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel)
            alerController.addAction(cancelAction)
            present(alerController, animated: true)
        }
        else{
            let newimage = newDogImage?.jpegData(compressionQuality: 1.0) ?? dogTobeDeleted.image
            dogTobeDeleted.name = deleteName.text
            dogTobeDeleted.favoriteFood = deleteFood.text
            dogTobeDeleted.color = deleteColor.text
            dogTobeDeleted.image = newimage
            updateImageDelegate?.edetingDelegateFunc(dogToDelete: dogTobeDeleted, dtStatus: false,iP: index)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    func getNewPhoto(){
        editeImage.image = newDogImage
    }
    
    func setFields(){
        updateImage.setTitle("\(dogTobeDeleted.name!)", for: .normal)
        updateImage.tintColor = .white
        deleteName.text = dogTobeDeleted.name
        deleteColor.text = dogTobeDeleted.color
        deleteFood.text = dogTobeDeleted.favoriteFood
        editeImage.image = UIImage(data: dogTobeDeleted.image!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "done", style: .plain, target: self, action: #selector(doneEdeting))
    }
    
    
    @IBAction func updateImages(_ sender: UIButton) {
        let updateAlert = UIAlertController(title: "Update dog Photo", message: nil, preferredStyle: .actionSheet)
        let photoAction = UIAlertAction(title: "Photo Library", style: .default){ [weak self] alertActn in
            self?.updatePhotoActionClicked()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        updateAlert.addAction(photoAction)
        updateAlert.addAction(cancelAction)
        present(updateAlert, animated: true)
    }
    
    @IBAction func deleteDogInfo(_ sender: UIButton) {
        let deleteAlert = UIAlertController(title: "DELETE Dog!", message: "If you click delete the dog will be deleted from the collection", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ [weak self] deleteing in
            self?.dogDeletionClicked()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(cancelAction)
        present(deleteAlert, animated: true)
    }
    
    func dogDeletionClicked() {
        updateImageDelegate?.edetingDelegateFunc(dogToDelete: dogTobeDeleted,dtStatus: true,iP: index)
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension EditDogViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let nimg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        else {
            print("")
            return
        }
        newDogImage = nimg
        print("should assign pic now")
        dismiss(animated: true)
    }
 
    func updatePhotoActionClicked() {
        updateImagePicker.delegate = self
        updateImagePicker.sourceType = .photoLibrary
        present(updateImagePicker, animated: true)
    }

}

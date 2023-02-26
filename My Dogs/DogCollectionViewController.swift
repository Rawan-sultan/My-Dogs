//
//  DogCollectionViewController.swift
//  My Dogs
//
//  Created by 라완 💕 on 11/05/1444 AH.
//

import UIKit



class DogCollectionViewController: UICollectionViewController {
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var dogCollectoinView = [DogEntity]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        fetchAllItems()
        collectionView.backgroundColor = .black
        collectionView.frame = view.bounds
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = UICollectionViewFlowLayout()
        let imgWidth = (view.frame.size.width/3.0)
        layout.itemSize = CGSize(width: imgWidth, height: imgWidth)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    @IBAction func buttin(_ sender: UIBarButtonItem) {
        let addingList = self.storyboard?.instantiateViewController(withIdentifier: "AddDogViewController") as! AddDogViewController
        addingList.imageDelegate = self
        self.navigationController?.pushViewController(addingList, animated: true)
    }
    
    func fetchAllItems(){
        do {
            self.dogCollectoinView = try managedContext.fetch(DogEntity.fetchRequest())
        }catch{
            print(error)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogCollectoinView.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DogsCollectionViewCell", for: indexPath) as! DogsCollectionViewCell
        cell.configDogImage(dogImageData: dogCollectoinView[indexPath.item],iP: indexPath)
        cell.delegate = self
        return cell
    }
}

extension DogCollectionViewController: UICollectionViewDelegateFlowLayout, editingPageDelegate, dogImageProtocol, cellDelegate{
    
    func edetingDelegateFunc(dogToDelete: DogEntity ,dtStatus: Bool,iP: IndexPath) {
        
        if dtStatus {
            self.dogCollectoinView.remove(at: iP.row)
        }
        else {
            updateDog(dogId: dogToDelete,indx: iP.row)
        }
        do {
            try self.managedContext.save()
        }catch{
            print(error)
        }
        self.collectionView.reloadData()
    }

    func updateDog(dogId: DogEntity,indx: Int){
        self.dogCollectoinView[indx].name = dogId.name
        self.dogCollectoinView[indx].color = dogId.color
        self.dogCollectoinView[indx].favoriteFood = dogId.favoriteFood
        self.dogCollectoinView[indx].image = dogId.image
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imgWidth = view.frame.size.width * 0.5
        let imgHeight = imgWidth
        return CGSize(width: imgWidth, height: imgHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    
    func dogCellTobeUpdated(cellDog: DogEntity,iP: IndexPath) {
        let edtPage = self.storyboard?.instantiateViewController(withIdentifier: "EditDogViewController") as! EditDogViewController
        edtPage.updateImageDelegate = self
        edtPage.dogTobeDeleted = cellDog
        edtPage.index = iP
        print(self.dogCollectoinView.count)
        self.navigationController?.pushViewController(edtPage, animated: true)
    }
    
    
    func selectedDogImage(selectedDog: DogEntity) {
        self.dogCollectoinView.append(selectedDog)
        do {
            try self.managedContext.save()
        }catch{
            print(error)
        }
        self.collectionView.reloadData()
    }

}

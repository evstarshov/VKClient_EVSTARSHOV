//
//  FriendsCollectionViewController.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 28.08.2021.
//

import UIKit

class FriendsCollectionViewController: UICollectionViewController {
    var galleryItems: [PhotoGallery] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // ------ Получение количества ячеек из массива
    
    func configureGal() {
        if galleryItems.count != 0 {
            collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        galleryItems.count
    }

    // ------- Конфигурация ячейки коллекции
    

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as?  FriendsCollectionCell
         else {return UICollectionViewCell()}

        cell.configureGallery(with: galleryItems[indexPath.item])
    
        return cell
    }
    

    

    // ------- Выбор ячейки и переход на другой экран
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        //if let selectedImage = Friends[indexPath.section]
////        defer {collectionView.deselectItem(at: indexPath, animated: true)}
//
//        let image = friendsArray[indexPath.row]
//        print(image)
//
//        let avatarVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AvatarVievControllerID") as! AvatarVievController
////                   navigationController?.pushViewController(avatarVC, animated: true)
////        avatarVC.modalPresentationStyle = .fullScreen
//        present(avatarVC, animated: true)
//        avatarVC.friend = image
//    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let selectedImage = segue.destination as? AvatarVievController
            else {return}
            let indexPath = sender as! IndexPath
        let selectedIndex = galleryItems[indexPath.item]
        selectedImage.setImage(images: galleryItems, indexAt: indexPath.row)
        }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "avatarSegue", sender: indexPath)
    }

}

    


// ------- Расширение для размера ячейки
extension FriendsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 150.0, height: 150.0)
    }
}

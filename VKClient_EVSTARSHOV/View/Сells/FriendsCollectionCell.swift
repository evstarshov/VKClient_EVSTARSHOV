//
//  FriendsCollectionCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 31.08.2021.
//

import UIKit

class FriendsCollectionCell: UICollectionViewCell {

    @IBOutlet var friendsLabel: UILabel!
    @IBOutlet var friendsImageView: UIImageView!
    
    private let animator = Animator()
    
    override func awakeFromNib() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapCollectionImageView))
        friendsImageView.addGestureRecognizer(gestureRecognizer)
        friendsImageView.isUserInteractionEnabled = true

    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func configureGallery(with mygallery: PhotoGallery){
        friendsLabel.text = mygallery.description
        friendsImageView.image = mygallery.galleryImage
        //groupLabel.text = friends.secondname
        contentMode = .scaleAspectFill
    }
    
    @objc private func tapCollectionImageView() {
        friendsImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            UIView.animate(
                withDuration: 1.0,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.2,
                options: .curveEaseOut,
                animations: {
                    self.friendsImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                },
                completion: nil)
        }
}

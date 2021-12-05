//
//  NewsPictureTableViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 23.11.2021.
//

import UIKit

class NewsPictureTableViewCell: UITableViewCell
//, UICollectionViewDataSource, UICollectionViewDelegate
{

    
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    @IBOutlet weak var newsPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        self.newsCollectionView.dataSource = self
//        self.newsCollectionView.delegate = self
//        self.newsCollectionView.register(UINib.init(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "newsCellID")
                
    }
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 15
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCellID", for: indexPath as IndexPath) as! NewsCollectionViewCell
//
//
//        return cell
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

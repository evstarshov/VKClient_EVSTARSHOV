//
//  NewsCollectionViewCell.swift
//  VKClient_EVSTARSHOV
//
//  Created by Евгений Старшов on 04.12.2021.
//

import UIKit

final class NewsCellModel {
    
    var cells: String? = ""
    
    init(cells: String?) {
        self.cells = cells
    }
    
}

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var newsPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func makeCells(model: NewsCellModel) {
        if let image = URL(string: model.cells ?? "") {
            newsPicture?.loadImage(url: image)
        }
    }

}

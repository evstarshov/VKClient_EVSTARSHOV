//
//  CollectionViewLayout.swift
//  Weather1640
//
//  Created by Юрий Султанов on 03.09.2021.
//

import UIKit

final class CollectionLayout: UICollectionViewLayout {
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    var columnsCount = 2
    var columnsHeight: CGFloat = 130.0
    private var totalCellsHeight: CGFloat = 0.0
    
    override func prepare() {
        super.prepare()
        cacheAttributes = [:]
        makeLayout()
    }
    
    private func makeLayout() {
        guard let collectionView = collectionView else { return }
        let collectionViewElements = collectionView.numberOfItems(inSection: 0)
        let bigWidthCell = collectionView.bounds.width
        let smallWidthCell = collectionView.bounds.width / CGFloat(columnsCount)
        
        var lastX: CGFloat = 0.0
        var lastY: CGFloat = 0.0
        
        for index in 0..<collectionViewElements {
            let indexPath = IndexPath(item: index, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            let isBigCell = (index + 1) % (columnsCount + 1) == 0
            
            if isBigCell {
                attributes.frame = CGRect(x: 0.0,
                                          y: lastY,
                                          width: bigWidthCell,
                                          height: columnsHeight)
                lastY += columnsHeight
            } else {
                attributes.frame = CGRect(x: lastX,
                                          y: lastY,
                                          width: smallWidthCell,
                                          height: columnsHeight)
                let isLastColumn = (index + 2) % (columnsCount + 1) == 0 || index == collectionViewElements - 1
                
                if isLastColumn {
                    lastX = 0.0
                    lastY += columnsHeight
                } else {
                    lastX += smallWidthCell
                }
            }
            
            cacheAttributes[indexPath] = attributes
        }
        
        totalCellsHeight = lastY
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cacheAttributes.values.filter { attributes in
            return rect.intersects(attributes.frame)
        }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cacheAttributes[indexPath]
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: self.collectionView?.frame.width ?? 0,
                      height: self.totalCellsHeight)
    }
}

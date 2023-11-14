//
//  SpriteCollectionViewCell.swift
//  PokeApp
//
//  Created by Federico Torres Mojica on 10/29/23.
//

import UIKit

class SpriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        newFrame.size.height = ceil(size.height)
        newFrame.size.width = ceil(size.height)
        layoutAttributes.frame = newFrame

        return layoutAttributes
    }

    
}

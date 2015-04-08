//
//  CollectionViewCell.swift
//  AL
//
//  Created by Pouria Almassi on 20150309.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var subtitleLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.bnr_yellowColor()

        imageView = UIImageView()
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
        
        subtitleLabel = UILabel()
        subtitleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        subtitleLabel.font = UIFont(name: "HelveticaNeue-Light", size: 16)
        subtitleLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        subtitleLabel.textAlignment = NSTextAlignment.Center
        subtitleLabel.numberOfLines = 0
        contentView.addSubview(subtitleLabel)

        let viewsDictionary = [
            "imageView": imageView,
            "subtitleLabel": subtitleLabel
        ]

        // imageView leading: inset 20 points from leading edge
        let imageLeadingConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: contentView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 20.0)
        imageLeadingConstraint.identifier = "imageLeadingConstraint"
        NSLayoutConstraint.activateConstraints([imageLeadingConstraint])
        
        // imageView trailing: inset 20 points from trailing edge
        let imageTrailingConstraint = NSLayoutConstraint(
            item: imageView,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: contentView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: -20.0)
        imageTrailingConstraint.identifier = "imageTrailingConstraint"
        NSLayoutConstraint.activateConstraints([imageTrailingConstraint])

        // subtitleLabel leading: subtitleLabel leading edge == imageView leading edge
        let subtitleLeadingConstraint = NSLayoutConstraint(
            item: subtitleLabel,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Leading,
            multiplier: 1.0,
            constant: 0.0)
        subtitleLeadingConstraint.identifier = "subtitleLeadingConstraint"
        NSLayoutConstraint.activateConstraints([subtitleLeadingConstraint])
        
        // subtitleLabel trailing: subtitleLabel trailing edge == imageView trailing edge
        let subtitleTrailingConstraint = NSLayoutConstraint(
            item: subtitleLabel,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: imageView,
            attribute: NSLayoutAttribute.Trailing,
            multiplier: 1.0,
            constant: 0.0)
        subtitleTrailingConstraint.identifier = "subtitleTrailingConstraint"
        NSLayoutConstraint.activateConstraints([subtitleTrailingConstraint])

        // top and bottom
        let verticalVFL = "V:|-[imageView]-[subtitleLabel]-(>=8)-|"
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(verticalVFL,
            options: nil,
            metrics: nil,
            views: viewsDictionary)
        NSLayoutConstraint.activateConstraints(verticalConstraints)
    }
}

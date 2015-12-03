//
//  ViewController.swift
//  Awesome Demo App
//
//  Created by Pouria Almassi on 20150401.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
{
    let simpleModelArray: [(String, String)] = [
        ("image1", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam dui libero, viverra non est euismod, porta suscipit neque."),
        ("image2", "Morbi non elementum ipsum. Donec quis lectus pharetra, pretium dui eu, porttitor turpis. Etiam sed erat orci."),
        ("image3", "Praesent blandit metus vel porttitor venenatis. Donec pharetra consectetur sodales. In eget metus justo."),
    ]
    var collectionView: UICollectionView!
    var pageControl: UIPageControl!

    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        view = UIView(frame: frame)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSizeMake(view.frame.size.width, view.frame.size.height - 40)
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .Horizontal

        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.pagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.bnr_yellowColor()
        view.addSubview(collectionView)

        pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.addTarget(self, action: Selector("pageControlTapped"), forControlEvents: UIControlEvents.TouchUpInside)
        pageControl.backgroundColor = UIColor.bnr_yellowColor()
        pageControl.numberOfPages = simpleModelArray.count
        view.addSubview(pageControl)

        let viewsDictionary = [
            "collectionView": collectionView,
            "pageControl": pageControl
        ]

        let collectionViewHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|",
            options: [],
            metrics: nil,
            views: viewsDictionary)
        NSLayoutConstraint.activateConstraints(collectionViewHorizontalConstraints)

        let pageControlHorizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[pageControl]|",
            options: [],
            metrics: nil,
            views: viewsDictionary)
        NSLayoutConstraint.activateConstraints(pageControlHorizontalConstraints)

        let verticalVFL = "V:|-[collectionView][pageControl(==40)]-|"
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(verticalVFL,
            options: [],
            metrics: nil,
            views: viewsDictionary)
        NSLayoutConstraint.activateConstraints(verticalConstraints)
    }

    // MARK: - UICollectionView Delegate & DataSource

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return simpleModelArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView.image = UIImage(named: simpleModelArray[indexPath.row].0)
        cell.subtitleLabel.text = simpleModelArray[indexPath.row].1
        return cell
    }

    // MARK: - UIScrollView Delegate

    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        updatePageControl()
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        updatePageControl()
    }

    func updatePageControl() {
        let newPage = Int(collectionView.contentOffset.x / collectionView.bounds.size.width)
        pageControl.currentPage = newPage
    }

    func pageControlTapped() {
        var frame = collectionView.frame
        frame.origin.x = collectionView.frame.size.width * CGFloat(pageControl.currentPage)
        frame.origin.y = collectionView.frame.origin.y
        collectionView.scrollRectToVisible(frame, animated: true)
    }
}


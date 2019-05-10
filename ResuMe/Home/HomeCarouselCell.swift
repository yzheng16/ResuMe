//
//  HomeCarouselCell.swift
//  ResuMe
//
//  Created by Yi Zheng on 2019-01-02.
//  Copyright © 2019 Yi Zheng. All rights reserved.
//

import UIKit

class HomeCarouselCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var carouselImageUrls: [String]?
    var timer: Timer?
    
    lazy var hCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = carouselImageUrls?.count {
            return count
        }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselImageCellId", for: indexPath) as! CarouselImageCell
        //cell.backgroundColor = .green
        cell.carouselImageUrl = carouselImageUrls?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cgPoint = CGPoint(x: frame.width, y: 0)
        collectionView.setContentOffset(cgPoint, animated: false)
        return 0
    }
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 3
        pc.currentPageIndicatorTintColor = .black
        pc.pageIndicatorTintColor = UIColor(r: 232, g: 236, b: 241)
        return pc
    }()
    
    // automatically switch
    @objc func handleSwitchToNextCell(){
        let cellSize = CGSize(width: frame.width, height: frame.height)
        let contentOffset = hCollectionView.contentOffset
        let rect = CGRect(x: contentOffset.x + cellSize.width, y: contentOffset.y, width: cellSize.width, height: cellSize.height)
        hCollectionView.scrollRectToVisible(rect, animated: true)
        
        let index = contentOffset.x / frame.width
        pageControl.currentPage = Int(index)
    }
    
    func startTimer() -> Timer{
        let timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(handleSwitchToNextCell), userInfo: nil, repeats: true)
        return timer
    }
    
    // manually switch
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let count = carouselImageUrls?.count else  {return}
        self.timer?.invalidate()
        let index = targetContentOffset.pointee.x / frame.width
        let imagesCount = CGFloat(count) - 2
        if index <= imagesCount && index > 0 {
            pageControl.currentPage = Int(index) - 1
        }
        self.timer = startTimer()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let count = carouselImageUrls?.count else  {return}
        let x = scrollView.contentOffset.x
        let imagesCount = CGFloat(count - 2)
        if x == frame.width * (imagesCount + 1){
            let cgPoint = CGPoint(x: frame.width, y: 0)
            scrollView.setContentOffset(cgPoint, animated: false)
            pageControl.currentPage = 0
        }else if x == 0{
            let cgPoint = CGPoint(x: frame.width * imagesCount, y: 0)
            scrollView.setContentOffset(cgPoint, animated: false)
            pageControl.currentPage = count
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //backgroundColor = .green
        hCollectionView.register(CarouselImageCell.self, forCellWithReuseIdentifier: "CarouselImageCellId")
        addSubview(hCollectionView)
        addSubview(pageControl)
        
        hCollectionView.fillSuperview()
        pageControl.anchor(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        self.timer = startTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CarouselImageCell: UICollectionViewCell {
    
    var carouselImageUrl: String?{
        didSet{
            guard let imageUrl = carouselImageUrl else {return}
            photoImageView.loadImage(urlString: imageUrl)
        }
    }
    
    let photoImageView: CustomImageView = {
        let civ = CustomImageView()
//        civ.backgroundColor = .red
        return civ
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(photoImageView)
        photoImageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



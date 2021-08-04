//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/2/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

protocol InvalidationDelegate {
    func invalidateCells()
}

class DrawingCell: UICollectionViewCell {
        
    var cellData: Story?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 100
        flowLayout.minimumLineSpacing = 100
        return flowLayout
    }()
        
    lazy var drawCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setupView() {
        self.contentView.addSubview(drawCollectionView)
        
        drawCollectionView.dataSource = self
        drawCollectionView.delegate = self

        drawCollectionView.register(DrawCell.self, forCellWithReuseIdentifier: "drawCell")
        NSLayoutConstraint.activate([
            drawCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            drawCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            drawCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            drawCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        var frame = layoutAttributes.frame
        frame.size.height = 100
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}

extension DrawingCell: InvalidationDelegate {
    func invalidateCells() {
        drawCollectionView.collectionViewLayout.invalidateLayout()
    }
}

extension DrawingCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "drawCell", for: indexPath) as! DrawCell
        cell.drawingPath = (cellData?.paths[indexPath.row])!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! DrawCell).applyAnimation()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        (cell as! DrawCell).removeAnimation()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        (cellData?.paths.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsCount = (cellData?.paths.count)!
        let spacing: CGFloat
        let width: Int

        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true {
            spacing = (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing + 70 + 95
            width = (Int(self.frame.width) - Int(spacing)) / 2
        } else {
            spacing = (collectionViewLayout as! UICollectionViewFlowLayout).minimumLineSpacing * CGFloat((itemsCount - 1)) + 70 + 95
            width = (Int(self.frame.width) - Int(spacing)) / itemsCount
        }
        return CGSize(width: width , height: 65)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 95)
    }
}

class DrawCell: UICollectionViewCell {
    
//    var isToAnimate: Bool?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var drawingPath: CGPath?
    {
        didSet{
            self.pathLayer.path = drawingPath
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let pathLayer = CAShapeLayer()
    private func setupViews() {
        self.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.layer.addSublayer(self.pathLayer)
        self.pathLayer.lineWidth = 1
        self.pathLayer.strokeColor = UIColor.white.cgColor
        self.pathLayer.fillColor = UIColor.clear.cgColor
        self.pathLayer.strokeEnd = 0
    }
    
    func adjustDrawingPosition() {
        if UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? true {
            self.pathLayer.position = CGPoint(x: self.frame.size.width/3, y: 0)
        } else {
            self.pathLayer.position = .zero
        }
    }
    
    var animation = CABasicAnimation(keyPath: "strokeEnd")
    func applyAnimation() {
        self.animation.fromValue = 0
        self.animation.toValue = 1
        self.animation.duration = 3
        self.animation.fillMode = .forwards;
        self.animation.isRemovedOnCompletion = false
        self.pathLayer.add(self.animation, forKey: "stroke")
    }
    
    func removeAnimation() {
        self.pathLayer.removeAnimation(forKey: "stroke")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        self.adjustDrawingPosition()
        return layoutAttributes
    }

}

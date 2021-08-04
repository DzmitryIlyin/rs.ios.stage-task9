//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: dzmitry ilyin
// On: 8/3/21
// 
// Copyright © 2021 RSSchool. All rights reserved.

import UIKit

class AutoInvalidatingLayout: UICollectionViewFlowLayout {
    
    // Compute the width of a full width cell
        // for a given bounds
        func widestCellWidth(bounds: CGRect) -> CGFloat {
            guard let collectionView = collectionView else {
                return 0
            }

            let insets = collectionView.contentInset
            let width = bounds.width - insets.left - insets.right
            
            if width < 0 { return 0 }
            else { return width }
        }
        
        // Update the estimatedItemSize for a given bounds
        func updateEstimatedItemSize(bounds: CGRect) {
            estimatedItemSize = CGSize(
                width: widestCellWidth(bounds: bounds),
                // Make the height a reasonable estimate to
                // ensure the scroll bar remains smooth
                height: 130
            )
        }

        // assign an initial estimatedItemSize by calling
        // updateEstimatedItemSize. prepare() will be called
        // the first time a collectionView is assigned
        override func prepare() {
            super.prepare()
            
            let bounds = collectionView?.bounds ?? .zero
            updateEstimatedItemSize(bounds: bounds)
        }
        
        // If the current collectionView bounds.size does
        // not match newBounds.size, update the
        // estimatedItemSize via updateEstimatedItemSize
        // and invalidate the layout
        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
            guard let collectionView = collectionView else {
                return false
            }
            
            let oldSize = collectionView.bounds.size
            guard oldSize != newBounds.size else { return false }
            
            updateEstimatedItemSize(bounds: newBounds)
            return true
        }

    
}

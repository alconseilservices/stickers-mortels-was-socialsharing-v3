//
//  DetailViewController.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 18/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var packStickersCollection: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packItem?.stickersNames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = packStickersCollection.dequeueReusableCell(withReuseIdentifier: "StickerImageCell", for: indexPath) as! StickerImageViewCell
        cell.stickerImage.image = UIImage(named: (packItem?.stickersNames[indexPath.row])!)
        let padding: CGFloat =  10
        let collectionViewSize = ((collectionView.frame.size.width - padding)/5)
        cell.stickerImage.frame = CGRect(x: 0, y: 0, width: collectionViewSize, height: collectionViewSize)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  10
        let collectionViewSize = ((collectionView.frame.size.width - padding)/5)
        return CGSize(width: collectionViewSize, height: collectionViewSize)
    }

    func configureView() {
        self.title = packItem?.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        packStickersCollection.delegate = self
        packStickersCollection.dataSource = self
        configureView()
    }

    var packItem: Pack? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}


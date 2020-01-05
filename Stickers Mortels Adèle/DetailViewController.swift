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
    private let spacing:CGFloat = 16.0
    private let origin: CGPoint = CGPoint(x: 0, y: 0)
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packItem?.stickersNames.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = packStickersCollection.dequeueReusableCell(withReuseIdentifier: "StickerImageCell", for: indexPath) as! StickerImageViewCell
        cell.stickerImage.image = UIImage(named: (packItem?.stickersNames[indexPath.row])!)
        cell.stickerImage.frame = CGRect(origin: origin, size: computeCellSize())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return computeCellSize()
    }
    
    func computeCellSize() -> CGSize {
        let numberOfItemsPerRow:CGFloat = 4
        let spacingBetweenCells:CGFloat = 16
           
        let totalSpacing = (2 * self.spacing) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (packStickersCollection.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sticker = (packItem?.stickersNames[indexPath.item])!
        let cell = collectionView.cellForItem(at: indexPath)
        showShareActionSheet(withSticker: sticker, overCell: cell!)
    }
    
    func showShareActionSheet(withSticker sticker: String, overCell cell: UICollectionViewCell) {
        let actionSheet: UIAlertController = UIAlertController(title: "\n\n\n\n\n\n", message: "", preferredStyle: .actionSheet)
        
        actionSheet.popoverPresentationController?.sourceView = cell.contentView
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: cell.contentView.bounds.midX, y: cell.contentView.bounds.midY, width: 0, height: 0)

        actionSheet.addAction(UIAlertAction(title: "Partager...", style: .default, handler: { action in
            self.showShareSheet(withSticker: sticker)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        actionSheet.addImageView(withImage: UIImage(named: sticker)!)
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        present(actionSheet, animated: true, completion: nil)
    }
    
    func showShareSheet(withSticker sticker: String) {
        let shareViewController: UIActivityViewController = UIActivityViewController(activityItems: [UIImage(named: sticker)!], applicationActivities: nil)
        shareViewController.popoverPresentationController?.sourceView = self.view
        shareViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        shareViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        present(shareViewController, animated: true, completion: nil)
    }

    func configureView() {
        self.title = packItem?.name
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(createActionsSheet))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        packStickersCollection.collectionViewLayout = layout
        self.automaticallyAdjustsScrollViewInsets = false
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
    
    @objc func createActionsSheet() -> Void {
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "Choisir une action", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Ajouter le pack à WhatsApp", style: .default, handler: { action in
            if(canSendToWhatsapp()) {
                sendToWhatsapp(fileName: self.packItem!.dataFileName)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        self.present(actionSheet, animated: true, completion: nil)
    }
    


}


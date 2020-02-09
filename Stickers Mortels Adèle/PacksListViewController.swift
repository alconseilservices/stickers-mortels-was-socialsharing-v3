//
//  MasterViewController.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 18/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import UIKit
import SafariServices
import FirebaseAnalytics

class PacksListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var packsTable: UITableView!
    private var packs: [Pack] = PackStore().packs

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Stickers Mortelle Adèle"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(createActionsSheet))
        packsTable.delegate = self
        packsTable.dataSource = self
        computeBannerImage()
        computePackTable()
        Analytics.setScreenName("PackList", screenClass: "PacksListViewController")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func createActionsSheet() -> Void {
        let actionSheet: UIAlertController = UIAlertController(title: "", message: "Choisir une action", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "CGU", style: .default, handler: { action in
            let svc = SFSafariViewController(url: NSURL(string: "http://applications-enfants.bayam.fr/page/cgu-stickers-mortelle-adele-application.html")! as URL)
            Analytics.logEvent("navigation", parameters: [
                "title":"CGU",
                "action":"clic : onglet"
            ])
            self.present(svc, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "L' univers Mortelle Adèle", style: .default, handler: { action in
            Analytics.logEvent("navigation", parameters: [
                "title":"Site web",
                "action":"clic : onglet"
            ])
            if let url = URL(string: "https://www.mortelleadele.com") {
                UIApplication.shared.open(url)
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Annuler", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func computePackTable() -> Void {
        self.view.addConstraint(NSLayoutConstraint(item: packsTable!, attribute: .width, relatedBy: .equal, toItem: mainView, attribute: .width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: packsTable!, attribute: .top, relatedBy: .equal, toItem: bannerImage, attribute: .bottom, multiplier: 1, constant: 50))
    }
    
    func computeBannerImage() -> Void {
        self.view.addConstraint(NSLayoutConstraint(item: self.bannerImage!, attribute: .width, relatedBy: .equal, toItem: mainView, attribute: .width, multiplier: 1, constant: 0))
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                let beginImage = CIImage(image: bannerImage.image!)
                if let filter = CIFilter(name: "CIColorInvert") {
                    filter.setValue(beginImage, forKey: kCIInputImageKey)
                    bannerImage.image = UIImage(ciImage: filter.outputImage!)
                }
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPackDetailsSegue" {
            if let indexPath = packsTable.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.packItem = packs[indexPath.row]
                Analytics.logEvent("navigation", parameters: [
                    "title":"pack : #" + packs[indexPath.row].name + "#",
                    "action":"clic : acces pack"
                ])
            }
        }
    }

    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackCell", for: indexPath) as! PackTableViewCell
        let packObject = packs[indexPath.row]
        cell.packIconImage.image = UIImage(named: packObject.iconName)
        cell.packNameLabel.text = packObject.name
        cell.packSizeLabel.text = packObject.size
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }


}


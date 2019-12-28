//
//  MasterViewController.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 18/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//

import UIKit

class PacksListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var packsTable: UITableView!
    private var packs: [Pack] = PackStore().packs

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
        packsTable.delegate = self
        packsTable.dataSource = self
        computeBannerImage()
        computePackTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        /*if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row] as! NSDate
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }*/
    }
    
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

    // MARK: - Table View

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] as! NSDate
        cell.textLabel!.text = object.description
        return cell
    }*/


}


//
//  Utils.swift
//  Stickers Mortels Adèle
//
//  Created by Amine on 28/12/2019.
//  Copyright © 2019 Bayard Presse. All rights reserved.
//
import Foundation
import UIKit

func sendToWhatsapp(fileName: String) -> Void {
    do {
        
        let jsonData: Data
        
        guard let file = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            fatalError("Couldn't find \(fileName) in main bundle.")
        }

        jsonData = try Data(contentsOf: file)

        var jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        jsonObject?["ios_app_store_link"] = nil
        jsonObject?["android_play_store_link"] = nil

        let dataToSend = try JSONSerialization.data(withJSONObject: jsonObject as Any, options: [])
        let pasteboard: UIPasteboard = UIPasteboard.general

        if #available(iOS 10.0, *) {
            pasteboard.setItems([["net.whatsapp.third-party.sticker-pack": dataToSend]], options: [UIPasteboard.OptionsKey.localOnly: true, UIPasteboard.OptionsKey.expirationDate: NSDate(timeIntervalSinceNow: 60)])
        } else {
            pasteboard.setData(dataToSend, forPasteboardType: "net.whatsapp.third-party.sticker-pack")
        }

        DispatchQueue.main.async {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string: "whatsapp://stickerPack")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(URL(string: "whatsapp://stickerPack")!)
            }
        }
        
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

func canSendToWhatsapp() -> Bool {
    if UIApplication.shared.canOpenURL(URL(string: "whatsapp://")!) {
       return true
    } else {
    return false
    }
}

func loadCGU() -> String {
    var cguText: String = ""
    do {
        guard let file = Bundle.main.url(forResource: "cgu", withExtension: "txt") else {
            fatalError("Couldn't find cgu file in main bundle.")
        }
        cguText = String(bytes: try Data(contentsOf: file), encoding: .utf8)!
    } catch let error as NSError {
        print(error.localizedDescription)
    }
    return cguText
}

extension UIAlertController {
    func addSpinner() {
        let activity: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
        view.addSubview(activity)

        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.addConstraint(NSLayoutConstraint(item: activity, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: activity.bounds.size.width))
        activity.addConstraint(NSLayoutConstraint(item: activity, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: activity.bounds.size.height))
        view.addConstraint(NSLayoutConstraint(item: activity, attribute: .centerXWithinMargins, relatedBy: .equal, toItem: view, attribute: .centerXWithinMargins, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: activity, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20.0))

        activity.startAnimating()
    }

    func addImageView(withImage image: UIImage) {
        var stickerImageViewLength: CGFloat = 100.0
        if #available(iOS 9.0, *) {
            stickerImageViewLength = 125
        }

        let stickerImageView: UIImageView = UIImageView(image: image)
        stickerImageView.translatesAutoresizingMaskIntoConstraints = false;
        view.addSubview(stickerImageView)

        stickerImageView.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: stickerImageViewLength))
        stickerImageView.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: stickerImageViewLength))
        view.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 10.0))
        view.addConstraint(NSLayoutConstraint(item: stickerImageView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0))
    }
}

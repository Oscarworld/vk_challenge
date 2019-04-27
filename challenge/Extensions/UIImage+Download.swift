//
//  UIImage+Download.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func download(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }
}

extension UIButton {
    
    func download(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    return
            }
            
            DispatchQueue.main.async() { [weak self] in
                self?.setImage(image, for: .normal)
            }
            }.resume()
    }
    
    func download(from link: String) {
        guard let url = URL(string: link) else { return }
        download(from: url)
    }
}

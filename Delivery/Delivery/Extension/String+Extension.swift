//
//  String+Extension.swift
//  Delivery
//
//  Created by Artsiom Korenko on 25.10.22.
//

import Foundation
import UIKit

// Request to get Image
extension String {
    var image: UIImage {
        guard let apiURL = URL(string: self) else { return UIImage() }
        let data = try! Data(contentsOf: apiURL)
        guard let image = UIImage(data: data) else { return UIImage() }
        return image
    }
}

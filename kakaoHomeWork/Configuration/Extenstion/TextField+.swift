//
//  TextField+.swift
//  kakaoHomeWork
//
//  Created by 노영재 on 2022/07/15.
//

import UIKit

extension UITextField {
    func addLeftImage(image: UIImage) {
        let leftImage = UIImageView(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        leftImage.image = image
        leftImage.tintColor = .gray
        self.leftView = leftImage
        self.leftViewMode = .always
    }
}

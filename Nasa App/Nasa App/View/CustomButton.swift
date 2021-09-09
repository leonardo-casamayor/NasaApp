//
//  CustomButton.swift
//  Nasa App
//
//  Created by Leonardo Casamayor on 20/08/2021.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {

    @IBInspectable
       var borderWidth: CGFloat {
           get {
               return layer.borderWidth
           }
           set {
               layer.borderWidth = newValue
           }
           
       }
       
       @IBInspectable var cornerRadius: CGFloat = 5 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = cornerRadius > 0
           }
       }

}

//
//  ViewExtensions.swift
//  Movies
//
//  Created by Sidharth J Dev on 19/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradientBackground(colorFrom: UIColor, colorTo: UIColor, borderColor: CGColor = UIColor.clear.cgColor, isTopDown: Bool = false, clippingRadius: CGFloat = 0) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colorFrom.cgColor, colorTo.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        if isTopDown{
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        self.layer.insertSublayer(gradient, at: 0)
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        //setting border
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = clippingRadius
        
    }
    
    func setGradientFrom(colors: [CGColor], borderColor: CGColor = UIColor.clear.cgColor, isTopDown: Bool = false) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colors
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        if isTopDown{
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1)
        }
        self.layer.insertSublayer(gradient, at: 0)
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true
        //setting border
        self.layer.borderColor = borderColor
        self.layer.borderWidth = 1
    }
    
    func makeCircular(color: UIColor = UIColor.black) {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
//        self.layer.cornerRadius = CGRecg
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1.0
        self.layer.borderColor = color.cgColor
    }
    
    func addShadow(color: UIColor, opacity: Float = 0.5, radius: CGFloat = 2.0, offset: CGSize)
    {
        let view = self
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOffset = offset
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
    
}

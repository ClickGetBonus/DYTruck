//
//  ViewUtil.swift
//  DYTruck
//
//  Created by Lan on 17/4/14.
//  Copyright © 2017年 TL. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addCornerBorder(_ color: UIColor, _ width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.layer.masksToBounds = true
    }
    
    var xibName: String {
        let clzzName = NSStringFromClass(self.classForCoder)
        let nameArray = clzzName.components(separatedBy: ".")
        var xibName = nameArray[0]
        if nameArray.count == 2 {
            xibName = nameArray[1]
        }
        return xibName
    }
    
    static var className: String {
        let clzzName = NSStringFromClass(self.classForCoder())
        let nameArray = clzzName.components(separatedBy: ".")
        var xibName = nameArray[0]
        if nameArray.count == 2 {
            xibName = nameArray[1]
        }
        return xibName
    }
    
    func loadViewWithNibName(_ fileName: String, owner: AnyObject) -> UIView {
        let nibs = Bundle.main.loadNibNamed(fileName, owner: owner, options: nil)
        return nibs![0] as! UIView
    }
    
    func initFromXIB() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: xibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        return view
    }
    
    static var nib: UINib {
        return UINib(nibName: self.className, bundle: nil)
    }
    
    func addShadow() {
        self.addShadow(color: kRGBColorFromHex(0x0b0b0b).cgColor, opacity: 0.3, radius: 8)
    }
    
    func addShadow(color: CGColor, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = color
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.clipsToBounds = false
    }
    
    func addVeilViewBelow(_ view: UIView, target: AnyObject, selector: Selector) {
        let veilView = UIView(frame: self.bounds)
        veilView.tag = 180333
        let tapRes = UITapGestureRecognizer(target: target, action: selector)
        veilView.addGestureRecognizer(tapRes)
        veilView.backgroundColor = UIColor.black
        veilView.alpha = 0
        self.insertSubview(veilView, belowSubview: view)
        
        UIView.animate(withDuration: 0.5) {
            veilView.alpha = 0.6
        }
    }
    
    func hideVeilView(_ timeInterval: TimeInterval) {
        if let veilView = self.viewWithTag(180333) {
            UIView.animate(withDuration: timeInterval, animations: { 
                veilView.alpha = 0
            }, completion: { (_) in
                veilView.removeFromSuperview()
            })
        }
    }
    
}




// MARK: - Animation
extension UIView {
    
    func transitionIn(_ offset: UIOffset, complete: (() -> Void)?) {
        
        let pointFrame = self.frame
        
        var beginFrame = self.frame
        beginFrame.origin.x += offset.horizontal
        beginFrame.origin.y += offset.vertical
        self.frame = beginFrame
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = pointFrame
        }) { _ in
            if complete != nil {
                complete!()
            }
        }
    }
    
    
    func transitionOut(_ offset: UIOffset, complete: @escaping () -> Void) {
        
        let pointFrame = CGRect(x: self.left + offset.horizontal,
                                y: self.top + offset.vertical,
                                width: self.width,
                                height: self.height)
        
        UIView.animate(withDuration: 0.5, animations: {
            self.frame = pointFrame
        }) { _ in
            complete()
        }
    }
    
    func rotation(by value: Double) {
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = value
        anim.duration = 0.2
        anim.isRemovedOnCompletion = true
        self.layer.add(anim, forKey: nil)
        self.layer.removeAllAnimations()
        UIView.animate(withDuration: 0.2) {
            self.transform = self.transform.rotated(by: CGFloat(value))
        }
    }
}


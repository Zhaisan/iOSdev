//
//  CustomSegue.swift
//  AnimationApp
//
//  Created by Zhaisan on 01.04.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    override func perform() {
        
        let destinationView = self.destination
        let source = self.source

        let containerView = source.view.superview
        let originalCenter = source.view.center

        destinationView.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        destinationView.view.center = originalCenter
        containerView?.addSubview(destinationView.view)

        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: { destinationView.view.transform = CGAffineTransform.identity
        }, completion: { success in
            source.present(destinationView, animated: false, completion: nil)
        })
    }
}

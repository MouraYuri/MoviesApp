//
//  AlertHelper.swift
//  iOSChallenge
//
//  Created by Yuri Moura on 21/01/21.
//

import Foundation
import UIKit

class AlertHelper {
    
    static let shared = AlertHelper()
    
    private init() {}
    
    func showErrorToast(on viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.red
        alert.view.layer.cornerRadius = 12
        alert.view.alpha = 0.25
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}

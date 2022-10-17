//
//  ViewController.swift
//  Delivery
//
//  Created by Artsiom Korenko on 16.10.22.
//

import UIKit
import SnapKit

protocol MenuVCProtocol: AnyObject {
    
}

class MenuVC: UIViewController, MenuVCProtocol {

    var presenter: MenuPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }

}


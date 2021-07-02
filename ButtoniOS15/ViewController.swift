//
//  ViewController.swift
//  ButtoniOS15
//
//  Created by Quentin Deschamps on 21/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var showMenuButton: UIButton!
    
    private var isCheckoutSelected: Bool = false
    
    private var numberOfItem: Int = 1
    
    private var isToggle: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// MARK: Menu
        let deleteCancel = UIAction(title: "Cancel", image: UIImage(systemName: "xmark")) { action in }
        let deleteConfirmation = UIAction(title: "Delete", image: UIImage(systemName: "checkmark"), attributes: .destructive) { action in }
        
        let delete = UIMenu(title: "Delete", image: UIImage(systemName: "trash"), options: .destructive, children: [deleteCancel, deleteConfirmation])
        
        let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in }
        
        let edit = UIMenu(title: "Edit...", children: [rename, delete])
        
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in }
        
        let mainMenu = UIMenu(title: "", children: [share, edit])
        
        showMenuButton.menu = mainMenu
        showMenuButton.showsMenuAsPrimaryAction = true
        showMenuButton.center = CGPoint(x: view.center.x, y: view.center.y - 300)
        
        let addToCartButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        addToCartButton.center = CGPoint(x: view.center.x, y: view.center.y - 200)
        addToCartButton.configuration = .addToCart(item: numberOfItem)
        addToCartButton.addAction(UIAction(handler: { _ in
            self.numberOfItem += 1
            let config = UIButton.Configuration.addToCart(item: self.numberOfItem)
            addToCartButton.configuration = config
        }), for: .touchUpInside)
        view.addSubview(addToCartButton)
        
        let checkoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        checkoutButton.center = CGPoint(x: view.center.x, y: view.center.y - 100)
        checkoutButton.configuration = .checkOut()
        checkoutButton.addAction(UIAction(handler: { _ in
            if self.isCheckoutSelected {
                self.isCheckoutSelected = false
            } else {
                self.isCheckoutSelected = true
            }
            var config = UIButton.Configuration.checkOut()
            config.showsActivityIndicator = self.isCheckoutSelected ? true : false
            config.background.backgroundColor = self.isCheckoutSelected ? UIColor.systemFill : UIColor.systemBlue
            checkoutButton.configuration = config
        }), for: .touchUpInside)
        view.addSubview(checkoutButton)
        
        let toggleButton = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        toggleButton.center = CGPoint(x: view.center.x, y: view.center.y)
        toggleButton.configuration = .toggle(isToggle: isToggle)
        toggleButton.addAction(UIAction(handler: { _ in
            self.isToggle = self.isToggle ? false : true
            let config = UIButton.Configuration.toggle(isToggle: self.isToggle)
            toggleButton.configuration = config
        }), for: .primaryActionTriggered)
        toggleButton.changesSelectionAsPrimaryAction = true
        view.addSubview(toggleButton)
    }
}

extension UIButton.Configuration {
    static func addToCart(item: Int) -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        config.title = "Add to Cart"
        config.image = UIImage(systemName: "cart.badge.plus")
        config.imagePlacement = .trailing
        config.buttonSize = .small
        config.subtitle = "\(item)x 2.99€"
        config.imagePadding = 5
        
        return config
    }
    
    static func checkOut() -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.image = UIImage(systemName: "cart.fill")
        config.imagePadding = 5
        config.title = "Checkout"
        
        return config
    }
    
    static func toggle(isToggle: Bool) -> UIButton.Configuration {
        var config = UIButton.Configuration.tinted()
        config.buttonSize = .small
        config.title = "Toggle \(isToggle ? "On" : "Off")"
        
        return config
    }
}


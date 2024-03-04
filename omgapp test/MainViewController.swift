//
//  MainViewController.swift
//  omgapp test
//
//  Created by Kirill Smirnov on 04.03.2024.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 = createButton(title: " SwiftUI integration example ", action: #selector(goToViewControllerRef))
        let button2 = createButton(title: " TableView example ", action: #selector(goToViewControllerT))
        let button3 = createButton(title: " CollectionView example ", action: #selector(goToViewControllerRect))
        
        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 20
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.25
        return button
    }
    
    @objc func goToViewControllerRef() {
        let viewController1 = ViewControllerTableRef()
        navigationController?.pushViewController(viewController1, animated: true)
    }
    
    @objc func goToViewControllerT() {
        let viewController2 = ViewControllerTable()
        navigationController?.pushViewController(viewController2, animated: true)
    }
    
    @objc func goToViewControllerRect() {
        let viewController3 = ViewControllerRect()
        navigationController?.pushViewController(viewController3, animated: true)
    }
}

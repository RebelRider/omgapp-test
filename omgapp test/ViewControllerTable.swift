//
//  ViewControllerTable.swift
//  omgapp test
//
//  Created by Kirill Smirnov on 04.03.2024.
//

import UIKit

class ViewControllerTable: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var data = [Int]()
    var timer = Timer()
    var isPressed = [IndexPath: Bool]()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.backgroundColor = .cyan
            tableView.backgroundColor = .gray
            
            for _ in 0..<100 {
                data.append(Int.random(in: 10...20))
            }
            
            tableView.frame = self.view.bounds
            tableView.dataSource = self
            tableView.delegate = self
            self.view.addSubview(tableView)
            
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabels), userInfo: nil, repeats: true)
        }
        
        @objc func updateLabels() {
            data = data.map { _ in Int.random(in: 0...99) }
            tableView.reloadData()
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.backgroundColor = .secondaryLabel
            
            let scrollView = UIScrollView()
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.distribution = .fillEqually
            stackView.spacing = 10
            
            for i in 0..<data[indexPath.row] {
                let label = UILabel()
                label.text = "\(data[i])"
                label.textAlignment = .center
                label.layer.borderWidth = 2
                label.layer.cornerRadius = 10
                label.isUserInteractionEnabled = true
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
                label.addGestureRecognizer(tapGesture)
                label.widthAnchor.constraint(equalToConstant: 55).isActive = true
                label.heightAnchor.constraint(equalToConstant: 55).isActive = true
                stackView.addArrangedSubview(label)
                
                let key = IndexPath(row: i, section: indexPath.row)
                if let pressed = isPressed[key], pressed {
                    label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                } else {
                    label.transform = CGAffineTransform.identity
                }
            }
            
            scrollView.addSubview(stackView)
            cell.contentView.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            stackView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.topAnchor.constraint(equalTo: cell.contentView.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor).isActive = true
            scrollView.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor).isActive = true
            scrollView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor).isActive = true
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 55
        }
        
        @objc func tapAction(sender: UITapGestureRecognizer) {
            guard let label = sender.view as? UILabel else { return }
            let point = sender.location(in: tableView)
            guard let indexPath = tableView.indexPathForRow(at: point) else { return }
            let index = IndexPath(row: label.superview?.subviews.firstIndex(of: label) ?? 0, section: indexPath.row)
            
            if let pressed = isPressed[index], pressed {
                UIView.animate(withDuration: 0.2, animations: {
                    label.transform = CGAffineTransform.identity
                })
                isPressed[index] = false
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    label.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                })
                isPressed[index] = true
            }
        }
    }

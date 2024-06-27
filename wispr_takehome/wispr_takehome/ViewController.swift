//
//  ViewController.swift
//  wispr_takehome
//
//  Created by Steven on 6/21/24.
//

import UIKit
import FleksySDK

class ViewController: UIViewController {
    
    private let settingsURL = "App-prefs:General&path=Keyboard"
    
    private let titleLabel: UILabel = {
        let temp = UILabel()
        
        temp.text = "Welcome to Typeface Keyboard"
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        temp.textAlignment = .center
        temp.numberOfLines = 0
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    
    private let subtitleLabel: UILabel = {
        let temp = UILabel()
        
        temp.text = "In order to add the keyboard to your device, go to keyboard settings and add the keyboard named 'wispr_keyboard'"
        temp.textColor = .black
        temp.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        temp.textAlignment = .center
        temp.numberOfLines = 0
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    
    private lazy var settingsButton: UIButton = {
        let temp = UIButton()
        
        temp.setTitle("Go to Settings", for: .normal)
        temp.setTitleColor(.black, for: .normal)
        temp.layer.cornerRadius = 8
        temp.layer.borderWidth = 1
        temp.layer.borderColor = UIColor.black.cgColor
        temp.addTarget(self, action: #selector(self.openKeyboardSettings), for: .touchUpInside)
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        return temp
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
        ])
        
        self.view.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            self.subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8),
            self.subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            self.subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
        ])
        
        self.view.addSubview(self.settingsButton)
        NSLayoutConstraint.activate([
            self.settingsButton.topAnchor.constraint(equalTo: self.subtitleLabel.bottomAnchor, constant: 32),
            self.settingsButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 24),
            self.settingsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -24),
            
        ])
    }

    @objc private func openKeyboardSettings() {
        guard let url = URL(string: self.settingsURL) else {
            return
        }
        
        UIApplication.shared.open(url)
    }
}


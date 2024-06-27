//
//  TypefaceView.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import UIKit

class TypefaceCell: UICollectionViewCell {
    
    public var typeface: TypefaceModel? {
        didSet {
            self.titleLabel.text = self.typeface?.fancyName
        }
    }
    
    private let titleLabel: UILabel = {
        let temp = UILabel()
        temp.textAlignment = .center
        temp.textColor = .black
        temp.backgroundColor = .clear
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    public func toggleView(isSelected: Bool) {
        self.contentView.backgroundColor = isSelected ? .systemGray3 : .clear
    }
}

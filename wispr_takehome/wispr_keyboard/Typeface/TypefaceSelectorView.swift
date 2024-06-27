//
//  TypefaceSelectorView.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import UIKit

protocol TypefaceSelectorViewDelegate: AnyObject {
    func didSelectTypeface(typeface: TypefaceModel)
}

class TypefaceSelectorView: UIView {
    
    public weak var delegate: TypefaceSelectorViewDelegate?
    
    private let typefaceSelectorViewModel = TypefaceSelectorViewModel()
    
    private var availableTypefaces: [TypefaceModel] = []
    
    private var selectedTypeface: TypefaceModel? {
        didSet {
            guard let typeface = self.selectedTypeface else { return }
            
            self.delegate?.didSelectTypeface(typeface: typeface)
        }
    }
    
    private let collectionView: UICollectionView = {
        let tempLayout = UICollectionViewFlowLayout()
        tempLayout.scrollDirection = .horizontal
        tempLayout.minimumLineSpacing = 0.0
        tempLayout.minimumInteritemSpacing = 0.0
        tempLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let tempCollection = UICollectionView(frame: .zero, collectionViewLayout: tempLayout)
        tempCollection.backgroundColor = .clear
        tempCollection.showsHorizontalScrollIndicator = false
        tempCollection.translatesAutoresizingMaskIntoConstraints = false
        return tempCollection
    }()
    
    private let cellID = String(describing: TypefaceCell.self)
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setupView()
        self.setupCollectionView()
        
        self.getData()
    }
    
    private func getData() {
        self.typefaceSelectorViewModel.getTypefaces()
    }
    
    private func setupView() {
        self.backgroundColor = .systemGray4
        
        self.typefaceSelectorViewModel.delegate = self
    }
    
    private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension TypefaceSelectorView: TypefaceSelectorViewModelDelegate {
    func didGetTypefaces(typefaces: [TypefaceModel]) {
        self.availableTypefaces = typefaces
        self.selectedTypeface = typefaces.first
        
        self.reloadData()
    }
    
    func errorGettingTypefaces() {
        self.availableTypefaces = []
        
        self.reloadData()
    }
}

extension TypefaceSelectorView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        self.collectionView.register(TypefaceCell.self, forCellWithReuseIdentifier: self.cellID)

        self.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.availableTypefaces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! TypefaceCell
            
        let dataForRow = self.availableTypefaces[indexPath.row]
        cell.typeface = dataForRow
        
        cell.toggleView(isSelected: dataForRow.name == self.selectedTypeface?.name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: self.collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for cell in collectionView.visibleCells {
            let cell = cell  as! TypefaceCell
            cell.toggleView(isSelected: false)
        }
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as! TypefaceCell
        selectedCell.toggleView(isSelected: true)
        
        self.selectedTypeface = selectedCell.typeface
    }
}

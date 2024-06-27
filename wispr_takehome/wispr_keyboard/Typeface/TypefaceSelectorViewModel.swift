//
//  TypefaceSelectorViewModel.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import Foundation

protocol TypefaceSelectorViewModelDelegate: AnyObject {
    func didGetTypefaces(typefaces: [TypefaceModel])
    
    func errorGettingTypefaces()
}

class TypefaceSelectorViewModel {
    public weak var delegate: TypefaceSelectorViewModelDelegate?
    
    public func getTypefaces() {
        guard let url = Bundle.main.url(forResource: "Typefaces", withExtension: "json") else {
            self.delegate?.errorGettingTypefaces()
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let typefaces = try JSONDecoder().decode([TypefaceModel].self, from: data)
            
            self.delegate?.didGetTypefaces(typefaces: typefaces)
        } catch {
            self.delegate?.errorGettingTypefaces()
        }
    }
    
}

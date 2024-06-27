//
//  KeyboardViewController.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import UIKit
import FleksyKeyboardSDK
import Combine

class KeyboardViewController: FleksyKeyboardSDK.FKKeyboardViewController {
    
    private var observations: Set<AnyCancellable> = []
    private var selectedTypeface: TypefaceModel?
    private let typefaceSelectorView = TypefaceSelectorView()
    private var typefaceSelectorViewIsSetup = false

    override func createConfiguration() -> KeyboardConfiguration {
        return KeyboardConfiguration(
            style: StyleConfiguration(),
            typing: TypingConfiguration(),
            license: self.createKeys()
        )
    }
    
    private func createKeys() -> LicenseConfiguration {
        let fleksyLicenseKey = ProcessInfo.processInfo.environment["fleksyLicenseKey"] ?? ""
        let fleksySecretKey = ProcessInfo.processInfo.environment["fleksySecretKey"] ?? ""
        
        return LicenseConfiguration(
            licenseKey: fleksyLicenseKey,
            licenseSecret: fleksySecretKey
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.subscribeToEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.observations.removeAll()
    }
    
    private func subscribeToEvents() {
        eventBus.activity
            .sink { [weak self] activityEvent in
                DispatchQueue.main.async {
                    self?.handleActivityEvent(activityEvent)
                }
            }
            .store(in: &observations)
    }

    private func handleActivityEvent(_ activityEvent: ActivityEvent) {
        switch activityEvent {
        case .keyboardAction(type: .tap(key: let key)):
            self.replaceText(with: key)
        default:
            break
        }
    }

    private func replaceText(with text: String) {
        let styledText = self.selectedTypeface?.convert(text) ?? text
        
        self.textDocumentProxy.deleteBackward()
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
        
        self.textDocumentProxy.insertText(styledText)
        self.textDocumentProxy.adjustTextPosition(byCharacterOffset: 1)
    }
    
    override var appIcon: UIImage? {
        return UIImage(systemName: "circle.hexagonpath.fill")
    }
    
    override func triggerOpenApp() {
        if !self.typefaceSelectorViewIsSetup {
            self.setupTypefaceSelector()
        }
        
        self.toggleTypefaceSelector()
    }
    
    private func toggleTypefaceSelector() {
        self.typefaceSelectorView.isHidden = !self.typefaceSelectorView.isHidden
    }
    
    private func setupTypefaceSelector() {
        self.typefaceSelectorView.delegate = self
        self.typefaceSelectorView.isHidden = true
        
        self.view.addSubview(self.typefaceSelectorView)
        self.typefaceSelectorView.translatesAutoresizingMaskIntoConstraints = false
        
        guard let appIconView = self.leadingTopBarView else { return }
        
        NSLayoutConstraint.activate([
            self.typefaceSelectorView.topAnchor.constraint(equalTo: view.topAnchor),
            self.typefaceSelectorView.leadingAnchor.constraint(equalTo: appIconView.trailingAnchor),
            self.typefaceSelectorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.typefaceSelectorView.heightAnchor.constraint(equalToConstant: self.topBarHeight)
        ])
        
        self.typefaceSelectorViewIsSetup = true
    }
    
}

extension KeyboardViewController: TypefaceSelectorViewDelegate {
    func didSelectTypeface(typeface: TypefaceModel) {
        self.selectedTypeface = typeface
        
        self.toggleTypefaceSelector()
    }
}

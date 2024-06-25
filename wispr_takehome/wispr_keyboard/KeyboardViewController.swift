//
//  KeyboardViewController.swift
//  wispr_keyboard
//
//  Created by Steven on 6/25/24.
//

import UIKit
import FleksyKeyboardSDK

class KeyboardViewController: FleksyKeyboardSDK.FKKeyboardViewController {

    override func createConfiguration() -> KeyboardConfiguration {
        let style = StyleConfiguration()

        let typing = TypingConfiguration()

        let licenseConfig = LicenseConfiguration(
            licenseKey: "<your-license-key>",
            licenseSecret: "<your-license-secret>"
        )

        return KeyboardConfiguration(
            style: style,
            typing: typing,
            license: licenseConfig
        )
    }
}

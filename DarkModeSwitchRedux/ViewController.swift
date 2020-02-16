//
//  ViewController.swift
//  DarkModeSwitchRedux
//
//  Created by YupinHuPro on 2/16/20.
//  Copyright © 2020 YupinHuPro. All rights reserved.
//

import UIKit

final class ViewController: UIViewController, Subscriber {
    var identifier = generateIdentitifer()
    @IBOutlet private weak var darkModeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        appStore.subscribe(self)
        if let state = appStore.state {
            self.update(state)
        }
    }

    deinit {
        appStore.unsubscribe(self)
    }

    @IBAction private func switchToggled(_ sender: UISwitch) {
        appStore.dispatch(ToggleSettingsAction(type: SettingActionKey.toggleDarkMode.rawValue))
    }

    func update(_ state: State) {
        if let settings = state["settings"] as? Dictionary<String, Bool> {
            if let darkMode = settings[SettingKey.darkMode.rawValue] {
                self.darkModeSwitch.isOn = darkMode
                self.view.backgroundColor = darkMode ? .black : .white
            }
        }
    }
}


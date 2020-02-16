//
//  Setting.swift
//  DarkModeSwitchRedux
//
//  Created by YupinHuPro on 2/16/20.
//  Copyright © 2020 YupinHuPro. All rights reserved.
//

import Foundation

enum SettingActionKey: String {
    case toggleDarkMode = "TOGGLE_DARK_MODE"
}

struct ToggleSettingsAction: ActionType {
    var type: String
    var data: Any { get { return "" } }
}

enum SettingKey: String {
    case darkMode = "darkMode"
}

func settingReducer(_ settings: Dictionary<String, Bool>?, action: ActionType) -> Dictionary<String, Bool> {
    guard let settings = settings else {
        return [
            SettingKey.darkMode.rawValue: false
        ]
    }

    var toggleKey = "undefined"
    switch action.type {
    case SettingActionKey.toggleDarkMode.rawValue:
        toggleKey = SettingKey.darkMode.rawValue
        break
    default: break
    }

    var newSettings: Dictionary<String, Bool> = [:]
    for (key, value) in settings {
        if toggleKey == key {
            newSettings[key] = !value
        } else {
            newSettings[key] = value
        }
    }
    return newSettings
}

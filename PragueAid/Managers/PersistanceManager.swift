//
//  PersistanceManager.swift
//  PragueAid
//
//  Created by Daniel Šlechta on 09.02.2021.
//  Copyright © 2021 Daniel Šlechta. All rights reserved.
//

import Foundation

enum Keys {
    static let filterSettings = "filterSettings"
}


class PersistanceManager {
    
    static let shared = PersistanceManager()
    private let defaults = UserDefaults.standard
    
    
    func loadFilterSettingsFromPersistance(completed: @escaping(Result<FilterSettings, PAError>) -> Void) {
        
        //check if any saved settings exist and if not, pass default ones.
        guard let filterSettingsData = defaults.object(forKey: Keys.filterSettings) as? Data else {
            let defaultSettings = FilterSettings(walkingDistance: false, medicalInstitutions: false, benu: true, drmax: true, teta: true, other: true)
            completed(.success(defaultSettings)); return
        }
        //decode saved settings.
        do {
            let decoder = JSONDecoder()
            let retrievedFilterSettings = try decoder.decode(FilterSettings.self, from: filterSettingsData)
            completed(.success(retrievedFilterSettings))
        } catch {
            completed(.failure(.unableToLoadFilterSettings))
        }
    }
    
    
    func saveFilterSettingsToPersistance(settings: FilterSettings) -> PAError? {
        do {
            let encoder = JSONEncoder()
            let encodedSettings = try encoder.encode(settings)
            defaults.set(encodedSettings, forKey: Keys.filterSettings)
            return nil
        } catch {
            return .unableToSaveFilterSettings
        }
    }
    
}

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
    static let targets = "targets"
}


class PersistanceManager {
    
    static let shared = PersistanceManager()
    private let defaults = UserDefaults.standard
    
    
    func loadFilterSettingsFromPersistance(completed: @escaping(Result<FilterSettings, PAError>) -> Void) {
        
        //check if any saved settings exist and if not, pass default ones.
        guard let filterSettingsData = defaults.object(forKey: Keys.filterSettings) as? Data else {
            let defaultSettings = FilterSettings(pharmacies: true, medicalInstitutions: false)
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
    
    
    func loadTargetsFromPersistance(completed: @escaping(Result<[Target], PAError>) -> Void) {
        
        guard let targetData = defaults.object(forKey: Keys.targets) as? Data else {
            completed(.success([])); return
        }
        do {
            let decoder = JSONDecoder()
            let retrievedTargets = try decoder.decode([Target].self, from: targetData)
            completed(.success(retrievedTargets))
        } catch {
            completed(.failure(.unableToLoadTargets))
        }
    }
    
    
    func saveTargetsToPersistance(targets: [Target]) -> PAError? {
        do {
            let encoder = JSONEncoder()
            let encodedSettings = try encoder.encode(targets)
            defaults.set(encodedSettings, forKey: Keys.targets)
            return nil
        } catch {
            return .unableToSaveTargets
        }
    }
    
}

//
//  CachedFeatureData.swift
//  FeatureFlags
//
//  Created by Tu Van on 05/10/2022.
//

class CachedFeatureData {
    private static let cachedKey = "cached_feature_data"
    
    static func storeFeature(data: Data?) {
        UserDefaults.standard.set(data, forKey: cachedKey)
        UserDefaults.standard.synchronize()
    }
    
    static func retriveFeature() -> Data? {
        return UserDefaults.standard.object(forKey: cachedKey) as? Data
    }
}

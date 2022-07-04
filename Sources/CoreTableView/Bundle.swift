//
//  Bundle.swift
//  BaseTableViewKit
//
//  Created by Слава Платонов on 08.02.2022.
//

import class Foundation.Bundle

/**
 Class to be searched in the Package files directory
 */
private class BundleFinder { }

/**
 Extension to the Bundle to be presentable in the App
 */
public extension Bundle {
    
    /**
     Variable to be used in the Package to find files / assets
     */
    static var current : Bundle = {
        let bundleName = "CoreTableView_CoreTableView"
        let candidates = [
            Bundle.main.bundleURL,
            Bundle.main.resourceURL,
            Bundle(for: BundleFinder.self).resourceURL,
            Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
        ]
        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }
        fatalError("🚧🚧🚧🚧🚧 Unable to find \(bundleName) bundle")
    }()
}

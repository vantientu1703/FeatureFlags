//
//  ViewController.swift
//  FeatureFlags
//
//  Created by Ross Butler on 10/18/2018.
//  Copyright (c) 2018 Ross Butler. All rights reserved.
//

import UIKit
import FeatureFlags

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var features: [Feature.Name] {
        return Feature.Name.allCases.filter { return Feature.named($0)?.isEnabled() == true }
    }
    
    var startDate = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showVariant()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(Date().timeIntervalSince(self.startDate))
    }
    
    func showVariant() {
        self.tableView.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    @IBAction func pushFeatureFlagsViewController(_ sender: UIButton) {
        FeatureFlags.deleteAllFeaturesFromCache()
        
        let navigationSettings = ViewControllerNavigationSettings(
            autoClose: true,
            closeButtonAlignment: .closeButtonLeftActionButtonRight,
            closeButton: .done,
            isModal: true,
            isNavigationBarHidden: false)
        FeatureFlagsUI.autoRefresh = true
        FeatureFlagsUI.presentFeatureFlags(delegate: self,
                                           navigationSettings: navigationSettings,
                                           presenter: self)
    }
}

extension ViewController: FeatureFlagsViewControllerDelegate {
    func viewControllerDidFinish() {
        printInformation()
        self.tableView.reloadData()
    }
    
    func printInformation() {
        FeatureFlags.printFeatureFlags()
        print("\n")
        FeatureFlags.printExtendedFeatureFlagInformation()
        print("\nTests information")
        self.showVariant()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.features.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FeatureTableViewCell else {
            return .init()
        }
        let ft = self.features[indexPath.row]
        if let feature = Feature.named(ft) {
            var content = ""
            switch ft {
            case .exampleFeatureOnOffTest:
                content.append("\nFeature name -> \(feature.name)\n")
                content.append("Is enabled? -> \(feature.isEnabled())\n")
                content.append("Is in group A? -> \(feature.isTestVariation(.enabled))\n")
                content.append("Is in group B? -> \(feature.isTestVariation(.disabled))\n")
                content.append("Test variation -> \(feature.testVariation())\n")
            case .exampleABTest:
                content.append("\nFeature name: \(feature.name)\n")
                let variant = feature.testVariation()
                content.append("Is enabled? -> \(feature.isEnabled())\n")
                content.append("Test variation: \(variant)\n")
            case .exampleMVTTest:
                content.append("\nFeature name -> \(feature.name)\n")
                content.append("Is enabled? -> \(feature.isEnabled())\n")
                content.append("Test variation -> \(feature.testVariation())\n")
            case .exampleUnlockFlag:
                content.append("\nFeature name -> \(feature.name)\n")
                content.append("Is enabled? -> \(feature.isEnabled())\n")
                content.append("Test is unlocked -> \(feature.isUnlocked())\n")
            case .exampleFeatureFlag:
                content.append("\nFeature name -> \(feature.name)\n")
                content.append("Is enabled? -> \(feature.isEnabled())\n")
                content.append("Test variation -> \(feature.testVariation())\n")
            default: break
            }
            cell.config(content)
        }
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  BaseViewController.swift
//  AppTemplate
//
//  Created by Miguel Solans on 17/06/2024.
//

import UIKit

public extension UIViewController {
    /// The name of the storyboard that instantiated the view controller.
    var storyboardName: String? {
        return self.storyboard?.value(forKey: "name") as? String
    }
}

/// A base class for a UIViewController
///
/// The `BaseViewController` class offers a convenient way to handle localized strings with multiple asset catalogues
/// by determining the appropriate localization table based on the Storyboard name.
///
/// If the UIViewController has not been instantiated by a UIStoryboard, one can use `localizationTableName` method
/// to manually set-up a localizable catalogue.
open class BaseViewController: UIViewController {
    
    /// The localization table name.
    ///
    /// If the `UIViewController` has been instantiated by a `UIStoryboard`,
    /// do not set this property and create a localizable string file with the same name as the storyboard.
    public var localizationTableName: String?
    
    /// The table name to be used internally for localization.
    fileprivate var tableName: String {
        
        if let name = localizationTableName {
            return name
        }
        
        guard let name = storyboardName else {
            fatalError("Storyboard name could not be determined and no localizationTableName was provided.")
        }
        
        return name
    }
    
    /// Obtains the localized string for a given key.
    ///
    /// - Parameter key: The key for a string in the localizable strings file.
    /// - Returns: A localized version of the string designated by `key` in the table `tableName`.
    public func localizedString(forKey key: String) -> String {
        return NSLocalizedString(key, tableName: tableName, comment: "")
    }
}

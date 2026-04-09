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

/// A base class that adds shared localization and haptic feedback helpers.
///
/// `BaseViewController` is designed to be extended across projects and
/// provides a common starting point for view controllers.
open class BaseViewController: UIViewController {

    // MARK: - Localization

    /// The localization table to use when resolving strings.
    ///
    /// If this view controller was instantiated from a storyboard and the
    /// storyboard name matches the Localizable strings file, this property can
    /// remain nil.
    public var localizationTableName: String?

    /// The bundle used when loading localized strings.
    public var localizationBundle: Bundle = .main

    fileprivate var defaultLocalizationTableName: String {
        if let tableName = localizationTableName {
            return tableName
        }

        guard let storyboardName = storyboardName else {
            fatalError("Storyboard name could not be determined and no localizationTableName was provided.")
        }

        return storyboardName
    }

    /// Returns a localized string using the view controller's configured
    /// localization table or a custom table name.
    ///
    /// - Parameters:
    ///   - key: The localization key.
    ///   - tableName: An optional override table name.
    ///   - comment: A comment for translators.
    /// - Returns: The localized value.
    public func localizedString(
        forKey key: String,
        tableName: String? = nil,
        comment: String = ""
    ) -> String {
        return NSLocalizedString(
            key,
            tableName: tableName ?? defaultLocalizationTableName,
            bundle: localizationBundle,
            comment: comment
        )
    }

    /// A convenience alias for `localizedString(forKey:)`.
    public func localized(_ key: String, comment: String = "") -> String {
        return localizedString(forKey: key, comment: comment)
    }

    // MARK: - Haptic Feedback

    public enum Feedback {
        case notification(UINotificationFeedbackGenerator.FeedbackType)
        case impact(UIImpactFeedbackGenerator.FeedbackStyle)
        case selection
    }

    public func triggerFeedback(_ feedback: Feedback) {
        switch feedback {
        case .notification(let type):
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(type)

        case .impact(let style):
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()

        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }
    }

    public func notifyFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        triggerFeedback(.notification(type))
    }

    public func impactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        triggerFeedback(.impact(style))
    }

    public func selectionFeedback() {
        triggerFeedback(.selection)
    }

    // MARK: - View Lifecycle Helpers

    open func setupView() {}
    open func setupBindings() {}
}

//
//  AlertBuilder.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import UIKit

final public class AlertBuilder {
    private var alertController: UIAlertController

    /// Initializes an alert builder.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message displayed by the alert.
    ///   - preferredStyle: The style of the alert controller. Default is `.alert`.
    public init(
        title: String = "",
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert
    ) {
        alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
    }

    /// Adds an action to the alert.
    ///
    /// - Parameter action: The action to add.
    /// - Returns: The alert builder.
    public func addAction(action: UIAlertAction) -> Self {
        alertController.addAction(action)
        return self
    }

    /// Adds an action to the alert with the provided title, style, and handler.
    ///
    /// - Parameters:
    ///   - title: The title of the action.
    ///   - style: The style of the action. Default is `.default`.
    ///   - handler: A closure to execute when the user selects the action. Default is `nil`.
    /// - Returns: The alert builder.
    public func addAction(
        title: String = "",
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        alertController.addAction(action)
        return self
    }

    /// Builds the alert controller.
    ///
    /// - Returns: The built `UIAlertController` instance.
    public func build() -> UIAlertController {
        alertController
    }
}

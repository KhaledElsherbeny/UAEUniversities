//
//  AlertBuilder.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import UIKit

final public class AlertBuilder {
    private var alertController: UIAlertController

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

    public func addAction(action: UIAlertAction) -> Self {
        alertController.addAction(action)
        return self
    }

    public func addAction(
        title: String = "",
        style: UIAlertAction.Style = .default,
        handler: ((UIAlertAction) -> Void)? = nil
    ) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        alertController.addAction(action)
        return self
    }

    public func build() -> UIAlertController {
        alertController
    }
}

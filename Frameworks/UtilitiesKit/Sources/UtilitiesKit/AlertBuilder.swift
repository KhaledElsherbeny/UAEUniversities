//
//  AlertBuilder.swift
//  WW-Exercise-01
//
//  Created by Khalid on 29/08/2022.
//  Copyright © 2022 Weight Watchers. All rights reserved.
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

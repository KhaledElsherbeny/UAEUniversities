//
//  LoadingView.swift
//  WW-Exercise-01
//
//  Created by Khalid on 27/08/2022.
//  Copyright © 2022 Weight Watchers. All rights reserved.
//

import UIKit

final public class LoadingView {

    static var spinner: UIActivityIndicatorView?

    public static func show() {
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.windows.first {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .large
                window.addSubview(spinner)

                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }

    public static func hide() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }
}

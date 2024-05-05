//
//  LoadingView.swift
//  UAEUniversities
//
//  Created by Khalid on 03/05/2024.
//

import UIKit

final public class LoadingView {

    private static var spinner: UIActivityIndicatorView?

    public static func start() {
        DispatchQueue.main.async {
            guard spinner == nil, let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                return
            }

            let spinner = UIActivityIndicatorView(frame: window.bounds)
            spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            spinner.style = .large
            window.addSubview(spinner)

            spinner.startAnimating()
            self.spinner = spinner
        }
    }

    public static func stop() {
        DispatchQueue.main.async {
            guard let spinner = spinner else { return }
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.spinner = nil
        }
    }
}


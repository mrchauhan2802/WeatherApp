//
//  Indicator.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

// MARK: - Indicator -

final class Indicator {
    
    // MARK: - Class Properties
    
    public static var animationDuration: TimeInterval = 0.4
    
    public static var isAnimationg: Bool {
        activityIndicatorView.isAnimating
    }

    private static let containerView: UIView = {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(svBaseContainer)
        
        NSLayoutConstraint.activate([
            svBaseContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            svBaseContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            svBaseContainer.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -30),
        ])
        
        return view
    }()
    
    private static var svBaseContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(activityIndicatorView)
        stackView.addArrangedSubview(messageLabel)
        return stackView
    }()
    
    private static var activityIndicatorView: UIActivityIndicatorView = {
        var indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        return indicatorView
    }()
    
    private static let messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.white
        return label
    }()
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Static Functions
    
    static func show(withText text: String? = nil, inView view: UIView? = nil) {
        guard !isAnimationg, let window = AppDelegate.shared.window else { return }
        
        let baseView = view ?? window
        
        baseView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: baseView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: baseView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: baseView.trailingAnchor),
        ])
        
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        messageLabel.text = text
        activityIndicatorView.startAnimating()

        UIView.animate(withDuration: animationDuration) {
            containerView.alpha = 1.0
            containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    static func hide() {
        guard isAnimationg else { return }
        
        UIView.animate(withDuration: animationDuration, animations: {
            containerView.transform = CGAffineTransform(scaleX: 2, y: 2)
            containerView.alpha = 0
        }) { _ in
            containerView.removeFromSuperview()
            activityIndicatorView.stopAnimating()
        }
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Initializers
    
    private init() {}
    
    // -----------------------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------------------

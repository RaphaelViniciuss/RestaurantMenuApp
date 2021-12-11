//
//  ActivityIndicatorOverlay.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

fileprivate let overlayViewTag: Int = 999
fileprivate let activityIndicatorViewTag: Int = 1000

extension UIView {

    func handleLoadingState(_ isLoading: Bool) {
        isLoading ? setActivityIndicatorView() : removeActivityIndicatorView()
    }
}

extension UIViewController {

    private var overlayContainerView: UIView {
        if let navigationView: UIView = navigationController?.view {
            return navigationView
        }
        return view
    }

    func handleLoadingState(_ isLoading: Bool) {
        overlayContainerView.handleLoadingState(isLoading)
    }
}

private extension UIView {

    // MARK: Views
    var activityIndicatorView: UIActivityIndicatorView {
        let indicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
        indicator.color = .white
        indicator.tag = activityIndicatorViewTag
        return indicator
    }

    var blurEffectView: UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8

//        blurEffectView.autoresizingMask = [
//            .flexibleWidth, .flexibleHeight
//        ]

        return blurEffectView
    }

    var overlayView: UIView {
        let view: UIView = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.tag = overlayViewTag
        return view
    }

    // MARK: Properties
    var isDisplayingActivityIndicatorOverlay: Bool {
        return currentActivityIndicatorView != nil && currentOverlayView != nil
    }

    var currentActivityIndicatorView: UIActivityIndicatorView? {
        viewWithTag(activityIndicatorViewTag) as? UIActivityIndicatorView
    }

    var currentOverlayView: UIView? {
        viewWithTag(overlayViewTag)
    }

    // MARK: Methods
    func setActivityIndicatorView() {

        guard !isDisplayingActivityIndicatorOverlay else {
            return
        }

        let overlayView: UIView = self.overlayView
        let activityIndicatorView: UIActivityIndicatorView = self.activityIndicatorView

        overlayView.addSubview(blurEffectView)
        overlayView.addSubview(activityIndicatorView)

        addSubview(overlayView)

        overlayView.layout(using: [
            overlayView.heightAnchor.constraint(equalTo: heightAnchor),
            overlayView.widthAnchor.constraint(equalTo: widthAnchor)
        ])

        blurEffectView.layout(using: [
            overlayView.heightAnchor.constraint(equalTo: overlayView.heightAnchor),
            overlayView.widthAnchor.constraint(equalTo: overlayView.widthAnchor)
        ])

        activityIndicatorView.layout(using: [
            activityIndicatorView.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
        ])

        activityIndicatorView.startAnimating()
    }

    func removeActivityIndicatorView() {

        guard let overlayView = currentOverlayView,
                let activityIndicator = currentActivityIndicatorView else {
            return
        }

        UIView.animate(withDuration: 0.2, animations: {
            overlayView.alpha = 0.0
            activityIndicator.stopAnimating()
        }) { _ in
            activityIndicator.removeFromSuperview()
            overlayView.removeFromSuperview()
        }
    }
}

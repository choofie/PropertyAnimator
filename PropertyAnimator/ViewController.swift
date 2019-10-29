//
//  ViewController.swift
//  PropertyAnimator
//
//  Created by Mate Lorincz on 2019. 10. 29..
//  Copyright © 2019. Mate Lorincz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var squareView: UIView!

    private var toEndAnimator: UIViewPropertyAnimator?
    private var toStartAnimator: UIViewPropertyAnimator?
    private var squareViewState: SquareViewState = .start
    private let animationDuration = 2.0

    private enum SquareViewState {
        case start
        case end
    }
}

// MARK: - IBActions

private extension ViewController {

    @IBAction func animateButtonPressed() {

        if toStartAnimator?.isRunning == true {
           toStartAnimator?.stopAnimation(true)
           fireToEndAnimation()
        } else if toEndAnimator?.isRunning == true {
            toEndAnimator?.stopAnimation(true)
            fireToStartAnimation()
        } else if squareViewState == .start {
            fireToEndAnimation()
        } else if squareViewState == .end {
            fireToStartAnimation()
        }
    }
}

// MARK: - Private Extension

private extension ViewController {

    func fireToEndAnimation() {

        guard toEndAnimator?.isRunning != true else {
            return
        }

        let progress = 1.0 - Double(self.squareView.frame.origin.x / (self.view.frame.width - self.squareView.frame.width))

        toEndAnimator = UIViewPropertyAnimator(duration: progress * animationDuration, curve: .linear, animations: {

            self.squareView.frame = CGRect(
                x: self.view.frame.width - self.squareView.frame.width,
                y: self.squareView.frame.origin.y,
                width: self.squareView.frame.width,
                height: self.squareView.frame.height
            )
        })

        toEndAnimator?.startAnimation()
        squareViewState = .end
    }

    func fireToStartAnimation() {

        guard toStartAnimator?.isRunning != true else {
            return
        }

        let progress = Double(self.squareView.frame.origin.x / (self.view.frame.width - self.squareView.frame.width))

        toStartAnimator = UIViewPropertyAnimator(duration: progress * animationDuration, curve: .linear, animations: {

            self.squareView.frame = CGRect(
                x: 0,
                y: self.squareView.frame.origin.y,
                width: self.squareView.frame.width,
                height: self.squareView.frame.height
            )
        })

        toStartAnimator?.startAnimation()
        squareViewState = .start
    }
}


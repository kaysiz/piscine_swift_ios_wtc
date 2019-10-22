//
//  ViewController.swift
//  day06
//
//  Created by kudakwashe on 2019/10/20.
//  Copyright © 2019 WeThinkCode. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var dynamicAnimator : UIDynamicAnimator!
    let gravityBehavior = UIGravityBehavior()
    let collisionBehavior = UICollisionBehavior()
    let elasticBehavior = UIDynamicItemBehavior()
    
    let motionManager = CMMotionManager()
    let motionQueue = OperationQueue.main
    
    var figures: [Shape] = []
    var select: Shape? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(btnTap(_:)))
        self.view.addGestureRecognizer(gesture)
        dynamicAnimator = UIDynamicAnimator(referenceView: view)
        gravityBehavior.magnitude = 2
        elasticBehavior.elasticity = 0.7
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator?.addBehavior(gravityBehavior)
        dynamicAnimator?.addBehavior(collisionBehavior)
        dynamicAnimator?.addBehavior(elasticBehavior)
        motionManager.startAccelerometerUpdates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if motionManager.isAccelerometerAvailable {
            motionManager.deviceMotionUpdateInterval = 0.01
            motionManager.startDeviceMotionUpdates(to: motionQueue, withHandler: gravityUpdated as! CMDeviceMotionHandler)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        motionManager.stopDeviceMotionUpdates()
    }
    
    func gravityUpdated(motion: CMDeviceMotion!, error: NSError!) {
        if (error != nil) {
            NSLog("\(String(describing: error))")
        }
        
        let grav : CMAcceleration = motion.gravity;
        
        let x = CGFloat(grav.x)
        let y = CGFloat(grav.y)
        var p = CGPoint(x: x, y: y)
        
        // Have to correct for orientation.
        let orientation = UIApplication.shared.statusBarOrientation;
        print("\n", orientation, "\n")
        
        if orientation == UIInterfaceOrientation.landscapeLeft {
            let t = p.x
            p.x = 0 - p.y
            p.y = t
        } else if orientation == UIInterfaceOrientation.landscapeRight {
            let t = p.x
            p.x = p.y
            p.y = 0 - t
        } else if orientation == UIInterfaceOrientation.portraitUpsideDown {
            p.x *= -1
            p.y *= -1
        }
        let v = CGVector(dx: x, dy: 0 - y)
        gravityBehavior.gravityDirection = v
    }

    @IBAction func btnTap(_ sender: UITapGestureRecognizer) {
        let figure = Shape()
        figure.translatesAutoresizingMaskIntoConstraints = true
        figure.center = sender.location(in: self.view)
        self.view.addSubview(figure)
        UIView.animate(withDuration: 0.1) {
            figure.bounds.size = CGSize(width: 100, height: 100)
        }
        figures.append(figure)
        gravityBehavior.addItem(figure)
        collisionBehavior.addItem(figure)
        elasticBehavior.addItem(figure)
    }
    
    @IBAction func btnPinch(_ sender: UIPinchGestureRecognizer) {
        var lastdist: CGFloat = 1
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in figures {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                gravityBehavior.removeItem(select!)
                self.view.bringSubviewToFront(select!)
                lastdist = sender.scale
            }
        case .changed:
            if select != nil {
                collisionBehavior.removeItem(select!)
                select!.bounds.size = CGSize(width: 100*(sender.scale/lastdist), height: 100*(sender.scale/lastdist))
                print(select!.bounds.size.width)
                print(select!.bounds.size.height)
                dynamicAnimator.updateItem(usingCurrentState: select!)
                collisionBehavior.addItem(select!)
            }
        default:
            if select != nil {
                gravityBehavior.addItem(select!)
                select = nil
            }
        }
    }
    
    @IBAction func btnPan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for form in figures {
                if (form.layer.presentation()?.frame.contains(tapLocation))! {
                    select = form
                    break
                }
            }
            if select != nil {
                self.view.bringSubviewToFront(select!)
                gravityBehavior.removeItem(select!)
            }
        case .changed:
            if select != nil {
                select!.center = sender.location(in: self.view)
                dynamicAnimator.updateItem(usingCurrentState: select!)
            }
        default:
            if select != nil {
                gravityBehavior.addItem(select!)
                select = nil
            }
        }
    }
    
    @IBAction func btnRotate(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .began:
            let tapLocation = sender.location(in: self.view)
            for f in figures {
                if (f.layer.presentation()?.frame.contains(tapLocation))! {
                    select = f
                    break
                }
            }
            if select != nil {
                gravityBehavior.removeItem(select!)
                self.view.bringSubviewToFront(select!)
            }
        case .changed:
            if select != nil {
                select!.transform = select!.transform.rotated(by: sender.rotation)
                dynamicAnimator.updateItem(usingCurrentState: select!)
                sender.rotation = 0
            }
        default:
            if select != nil {
                gravityBehavior.addItem(select!)
                select = nil
            }
        }
    }
}


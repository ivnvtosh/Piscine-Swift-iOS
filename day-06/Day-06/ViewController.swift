//
//  ViewController.swift
//  Day-06
//
//  Created by Anton Ivanov on 20.08.2022.
//

import UIKit
import CoreMotion


class ViewController: UIViewController {

	private var animator = UIDynamicAnimator()
	private let gravity = UIGravityBehavior(items: [])
	private let collision = UICollisionBehavior(items: [])
	private let behavior = UIDynamicItemBehavior(items: [])
	private var objects: Objects = []
	private var currentObject: Object?
	private var motionManager = CMMotionManager()


	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.backgroundColor = .systemBackground
		self.view.addGestureRecognizer(self.tapGestureRecognizer)

		self.animator = UIDynamicAnimator(referenceView: self.view)

		self.gravity.magnitude = 1
		self.collision.translatesReferenceBoundsIntoBoundary = true
		self.behavior.allowsRotation = true
		self.behavior.elasticity = 0.33

		self.animator.addBehavior(gravity)
		self.animator.addBehavior(collision)
		self.animator.addBehavior(behavior)

		if motionManager.isAccelerometerAvailable {
			motionManager.accelerometerUpdateInterval = 0.1
			motionManager.startAccelerometerUpdates(
				to: OperationQueue.main,
				withHandler: accelerometerAction
			)
		}

	}



//			MARK: - CREATE
	private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
			let gestureRecognizer = UITapGestureRecognizer(
				target: self,
				action: #selector(tapAction(sender:))
			 )

			gestureRecognizer.numberOfTapsRequired = 1
			gestureRecognizer.numberOfTouchesRequired = 1

			self.view.isUserInteractionEnabled = true

			return gestureRecognizer
		}()

		@objc private func tapAction(sender: UITapGestureRecognizer) {
			let location = sender.location(in: self.view)

			print("CREATE", objects.count + 1)

			let object = Object(
				frame: CGRect(
					x: location.x - 50,
					y: location.y - 50,
					width: 100,
					height: 100
				)
			)

			object.tag = objects.count + 1

			let panGesture = UIPanGestureRecognizer(
				target: self,
				action: #selector(moveAction(sender:))
			)
			let pinchGesture = UIPinchGestureRecognizer(
				target: self,
				action: #selector(scaleAction(sender:))
			)
			let rotationGesture = UIRotationGestureRecognizer(
				target: self,
				action: #selector(rotateAction(sender:))
			)

			object.addGestureRecognizer(panGesture)
			object.addGestureRecognizer(pinchGesture)
			object.addGestureRecognizer(rotationGesture)

			self.view.addSubview(object)

			self.objects.append(object)
			self.gravity.addItem(object)
			self.collision.addItem(object)
			self.behavior.addItem(object)
		}



//		      MARK: - MOVE
		@objc private func moveAction(sender: UIPanGestureRecognizer) {
			guard let target = sender.view else {
				return
			}

			switch sender.state {
			case .began:
				print("MOVE BEGAN", target.tag)
				gravity.removeItem(target)

			case .changed:
				print("MOVE CHANGER", target.tag)
				target.center = sender.location(in: self.view)
				self.animator.updateItem(usingCurrentState: target)

			case .ended:
				print("MOVE ENDED", target.tag)
				gravity.addItem(target)

			default:
				break
			}
		}



//		      MARK: - SCALE
		@objc private func scaleAction(sender: UIPinchGestureRecognizer) {
			guard let target = sender.view else {
				return
			}

			switch sender.state {
			case .began:
				print("SCALE BEGAN", target.tag)
				gravity.removeItem(target)

			case .changed:
				print("SCALE CHANGER", target.tag)
				self.collision.removeItem(target)
				self.behavior.removeItem(target)
				target.bounds.size.width *= sender.scale
				target.bounds.size.height *= sender.scale
				if target.layer.cornerRadius != 0 {
					target.layer.cornerRadius *= sender.scale
				}
				sender.scale = 1
				self.collision.addItem(target)
				self.behavior.addItem(target)
				self.animator.updateItem(usingCurrentState: target)

			case .ended:
				print("SCALE ENDED", target.tag)
				gravity.addItem(target)

			default:
				break
			}
		}


//		      MARK: - ROTATE
		@objc private func rotateAction(sender: UIRotationGestureRecognizer) {
			guard let target = sender.view else {
				return
			}

			switch sender.state {
			case .began:
				print("ROTATE BEGAN", target.tag)
				gravity.removeItem(target)

			case .changed:
				print("ROTATE CHANGER", target.tag)
				self.collision.removeItem(target)
				self.behavior.removeItem(target)
				target.transform = CGAffineTransform(rotationAngle: sender.rotation)
				self.collision.addItem(target)
				self.behavior.addItem(target)
				self.animator.updateItem(usingCurrentState: target)

			case .ended:
				print("ROTATE ENDED", target.tag)
				gravity.addItem(target)
			default:
				break
			}
		}




//		 MARK: - ACCELEROEMETER
	func accelerometerAction(data: CMAccelerometerData?, error: Error?) {
		if let accelerometerData = data {
			let accelerationX = CGFloat(accelerometerData.acceleration.x)
			let accelerationY = CGFloat(accelerometerData.acceleration.y)
			let accelerationVector = CGVector(dx: accelerationX, dy: -accelerationY)
			self.gravity.gravityDirection = accelerationVector
		}
	}


}


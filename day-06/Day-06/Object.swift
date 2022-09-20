//
//  Object.swift
//  Day-06
//
//  Created by Anton Ivanov on 20.08.2022.
//

import UIKit

enum Figure {
	case square
	case circle
}

class Object: UIView {

	private let color: UIColor = {
		switch arc4random_uniform(6) {
		case 0:
			return .red
		case 1:
			return .green
		case 2:
			return .blue
		case 3:
			return .purple
		case 4:
			return .orange
		case 5:
			return .brown
		default:
			return .tintColor
		}
	}()

	
	private let figure: Figure = {
		switch arc4random_uniform(2) {
		case 0:
			return .circle
		default:
			return .square
		}
	}()

	public var size = CGSize(width: 100.0, height: 100.0)

	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = color
		layer.cornerRadius = figure == .square ? 0 : CGFloat(max(size.width, size.width) / 2)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}


typealias Objects = [Object]


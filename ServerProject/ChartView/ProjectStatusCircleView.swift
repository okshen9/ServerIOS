//
//  ProjectStatusCircleView.swift
//
//  Created by Artem Neshko on 4/1/20.
//

import UIKit

class ProjectStatusCircleView: UIView {
	
	// MARK: - Constants
	
	private enum Constants {
		static let redCircleColor = [UIColor(red: 0.89, green: 0.27, blue: 0.37, alpha: 1).cgColor, UIColor(red: 0.76, green: 0.19, blue: 0.29, alpha: 1).cgColor]
		static let yellowCircleColor = [UIColor(red: 0.91, green: 0.52, blue: 0.02, alpha: 1).cgColor, UIColor(red: 1, green: 0.61, blue: 0.01, alpha: 1).cgColor]
		static let greenCircleColor = [UIColor(red: 0.5, green: 0.6, blue: 0.23, alpha: 1).cgColor, UIColor(red: 0.64, green: 0.78, blue: 0.27, alpha: 1).cgColor]
	}
	
	// MARK: - Initialization
	
	init(status: DeliveryStatusType, diameter: CGFloat, center: CGPoint) {
		super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
		
		configure(status: status, diameter: diameter, center: center)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Configuration
	
	private func configure(status: DeliveryStatusType, diameter: CGFloat, center: CGPoint) {
		self.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
		self.center = center
		self.layer.cornerRadius = self.frame.width / 2
		self.layer.addSublayer(applyGradient(for: status))
		self.layer.masksToBounds = true
	}
	
	private func applyGradient(for status: DeliveryStatusType) -> CAGradientLayer {
		let gradient = CAGradientLayer()
		
		switch status {
		case .green:
			gradient.colors = Constants.greenCircleColor
		case .amber:
			gradient.colors = Constants.yellowCircleColor
		case .red:
			gradient.colors = Constants.redCircleColor
		case .gray:
			gradient.colors = [UIColor.gray]
		}
		
		gradient.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
		gradient.locations = [0, 1]
		gradient.startPoint = CGPoint(x: 0.17, y: 0.15)
		gradient.endPoint = CGPoint(x: 0.84, y: 0.82)
		return gradient
	}
}

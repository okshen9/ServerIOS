//
//  ProjectStatusChartView.swift
//
//  Created by Artem Neshko on 4/2/20.
//

import UIKit

class ProjectStatusChartView: UIView {
	
	// MARK: - Constants
	
	private enum Constants {
		static let outerCircleDiameter: CGFloat = 110
		static let innerCircleDiameter: CGFloat = 88
		
		static let bigCircleDiameter: CGFloat = 40
		static let smallCircleDiameter: CGFloat = 28
		
		static let separatorInsets = 16
		static let horizontalLinesPositions = [55, 78, 101]
	}
	
	// MARK: - Properties
	
	var previousStatus: DeliveryStatusType = .green
	var currentStatus: DeliveryStatusType = .green
	var forecastStatus: DeliveryStatusType = .green
	
	// MARK: - Configuration
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		configure()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		configure()
	}
	
	private func configure() {
		self.subviews.forEach { $0.removeFromSuperview() }
		self.layer.sublayers = nil
		
		self.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
		
		self.backgroundColor = .white
		
		self.layer.addSublayer(drawHorizontalLines())
		self.layer.addSublayer(drawCircle(for: self.currentStatus))
		self.addCurvesBetweenStatuses()
	}
	
	func configure(_ previousStatus: DeliveryStatusType?, _ currentStatus: DeliveryStatusType?, _ forecastStatus: DeliveryStatusType?) {
		self.previousStatus = previousStatus ?? .gray
		self.currentStatus = currentStatus ?? .gray
		self.forecastStatus = forecastStatus ?? .gray
		
		self.configure()
	}
	
	// MARK: - Horizontal lines drawing
	
	private func drawHorizontalLines() -> CAShapeLayer {
		let separatorLine = CAShapeLayer()
		
		for position in Constants.horizontalLinesPositions {
			let leftPoint = CGPoint(x: Constants.separatorInsets, y: position)
			let rightPoint = CGPoint(x: Int(self.frame.size.width) - Constants.separatorInsets, y: position)
			separatorLine.addSublayer(drawLine(startPoint: leftPoint, endPoint: rightPoint, lineColor: .lightGray, lineWidth: 0.5))
		}
		
		return separatorLine
	}
	
	private func drawLine(startPoint: CGPoint, endPoint: CGPoint, lineColor: UIColor, lineWidth: CGFloat) -> CAShapeLayer {
		let line = CAShapeLayer()
		let path = UIBezierPath()
		
		path.move(to: startPoint)
		path.addLine(to: endPoint)
		
		line.path = path.cgPath
		line.lineWidth = lineWidth
		line.strokeColor = lineColor.cgColor
		line.fillColor = UIColor.clear.cgColor
		
		return line
	}
	
	// MARK: - Circles drawing
	
	private func drawCircle(for status: DeliveryStatusType) -> CAShapeLayer {
		let circlesContainer = CAShapeLayer()
		let center = CGPoint(x: self.center.x, y: CGFloat(Constants.horizontalLinesPositions[status == .gray ? 1 : status.rawValue]))
		let innerCircle = drawCircle(center: center, diameter: Constants.innerCircleDiameter, color: colorForBackgroundCircle(status: status, isInnerColor: true))
		let outerCircle = drawCircle(center: center, diameter: Constants.outerCircleDiameter, color: colorForBackgroundCircle(status: status, isInnerColor: false))
		
		circlesContainer.addSublayer(outerCircle)
		circlesContainer.addSublayer(innerCircle)
		return circlesContainer
	}
	
	private func drawCircle(center: CGPoint, diameter: CGFloat, color: UIColor) -> CAShapeLayer {
		let circle = CAShapeLayer()
		let path = UIBezierPath(ovalIn: CGRect(x: center.x - diameter/2, y: center.y - diameter/2, width: diameter, height: diameter))
		
		circle.path = path.cgPath
		circle.fillColor = color.cgColor
		return circle
	}
	
	private func setCircle(for status: DeliveryStatusType, center: CGPoint, diameter: CGFloat) -> UIImageView {
		let circle = UIImageView()
		circle.frame = CGRect(x: center.x, y: center.y, width: diameter, height: diameter)
		
		circle.center = center
		circle.image = circleImage(for: status, isOutdated: false)
		
		return circle
	}
	
	private func circleImage(for status: DeliveryStatusType, isOutdated: Bool) -> UIImage {
		var image = UIImage()
		
		switch status {
		case .green:
			image = isOutdated ? #imageLiteral(resourceName: "st_outdated_positive_40") : #imageLiteral(resourceName: "st_green_positive_40")
		case .amber:
			image = isOutdated ? #imageLiteral(resourceName: "st_outdated_neutral_40") : #imageLiteral(resourceName: "st_orange_neutral_40")
		case .red:
			image = isOutdated ? #imageLiteral(resourceName: "st_outdated_negative_40") : #imageLiteral(resourceName: "st_red_negative_40")
		case .gray:
			image = #imageLiteral(resourceName: "st_gray_notset_40")
		}
		
		return image
	}
	
	private func colorForBackgroundCircle(status: DeliveryStatusType, isInnerColor: Bool) -> UIColor {
		var color = UIColor()
		
		switch status {
		case .green:
			color = UIColor(hexString: isInnerColor ? "#D6E6AC" : "#E8F1D0")
		case .amber:
			color = UIColor(hexString: isInnerColor ? "#FFD399" : "#FFE6C5")
		case .red:
			color = UIColor(hexString: isInnerColor ? "#F7CBD2" : "#FBE3E7")
		case .gray:
			color = UIColor.gray
		}
		
		return color
	}
	
	private func colorForCurve(status: DeliveryStatusType) -> UIColor {
		var color = UIColor()
		
		switch status {
		case .green:
			color = UIColor(red: 0.64, green: 0.78, blue: 0.27, alpha: 1)
		case .amber:
			color = UIColor(red: 1, green: 0.61, blue: 0.1, alpha: 1)
		case .red:
			color = UIColor(red: 0.76, green: 0.19, blue: 0.29, alpha: 1)
		case .gray:
			color = UIColor.gray
		}
		
		return color
	}
	
	// MARK: - Draw curves
	
	private func drawCurveBetweenPoints(start: CGPoint, end: CGPoint, position: ProjectStatusTime) -> CALayer {
		let isStatusPrevious = position == .previous
		let curve = CAShapeLayer()
		let path = UIBezierPath()
		
		let firstControlPoint = curveControlPoint(start: start, end: end, step: 0.3)
		let secondControlPoint = curveControlPoint(start: start, end: end, step: 0.7)
		
		path.move(to: start)
		path.addCurve(to: end, controlPoint1: firstControlPoint, controlPoint2: secondControlPoint)
		curve.path = path.cgPath
		curve.lineWidth = 2
		curve.lineCap = .round
		curve.strokeColor = UIColor.black.cgColor
		curve.fillColor = UIColor.clear.cgColor
		curve.lineDashPattern = isStatusPrevious ? nil : [5, 5]
		
		let currentStatusColor = self.colorForCurve(status: currentStatus)
		let firstColor = isStatusPrevious ? self.colorForCurve(status: previousStatus) : currentStatusColor
		let secondColor = !isStatusPrevious ? self.colorForCurve(status: forecastStatus) : currentStatusColor
		
		let gradient = CAGradientLayer()
		gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
		gradient.colors = [firstColor.cgColor, secondColor.cgColor]
		gradient.startPoint = CGPoint(x: 0, y: 0.5)
		gradient.endPoint = CGPoint(x: 1, y: 0.5)
		gradient.locations = [(isStatusPrevious ? 0.2 : 0.5), (isStatusPrevious ? 0.5 : 0.8)]
		gradient.mask = curve
		
		return gradient
	}
	
	private func curveControlPoint(start: CGPoint, end: CGPoint, step: CGFloat) -> CGPoint {
		let controlValue = min(max(step, 0), 1)
		var mutableStart = start
		var mutableEnd = end
		
		if start.x > end.x {
			let oldStartPoint = mutableStart
			mutableStart.x = mutableEnd.x
			mutableEnd.x = oldStartPoint.x
			mutableStart.y = mutableEnd.y
			mutableEnd.y = oldStartPoint.y
		}
		
		let fromTopToBottom = mutableStart.y < mutableEnd.y
		let isFirstPoint = step < 0.5
		let equalYPos = mutableStart.y == mutableEnd.y || abs(mutableStart.y - mutableEnd.y) < 2
		let yOffset: CGFloat = 10
		
		let xPosition = mutableStart.x + abs(mutableEnd.x - mutableStart.x) * controlValue
		var yPosition = isFirstPoint ? mutableStart.y : mutableEnd.y
		
		yPosition += !((!fromTopToBottom && isFirstPoint) || (fromTopToBottom && !isFirstPoint)) ? -yOffset : yOffset
		yPosition = equalYPos ? mutableEnd.y : yPosition
		
		let controlPoint = CGPoint(x: xPosition, y: yPosition)
		return controlPoint
	}
	
	private func addCurvesBetweenStatuses() {
		let currentStatusPoint = CGPoint(x: self.center.x, y: CGFloat(Constants.horizontalLinesPositions[currentStatus == .gray ? 1 : currentStatus.rawValue]))
		let forecastStatusPoint = CGPoint(x: self.frame.size.width - 48, y: CGFloat(Constants.horizontalLinesPositions[forecastStatus == .gray ? 1 : forecastStatus.rawValue]))
		let previousStatusPoint = CGPoint(x: 48, y: CGFloat(Constants.horizontalLinesPositions[previousStatus == .gray ? 1 : previousStatus.rawValue]))
		
		self.layer.addSublayer(drawCurveBetweenPoints(start: currentStatusPoint, end: forecastStatusPoint, position: .forecast))
		self.layer.addSublayer(drawCurveBetweenPoints(start: previousStatusPoint, end: currentStatusPoint, position: .previous))
		
		self.addSubview(setCircle(for: currentStatus, center: currentStatusPoint, diameter: Constants.bigCircleDiameter))
		self.addSubview(setCircle(for: previousStatus, center: previousStatusPoint, diameter: Constants.smallCircleDiameter))
		self.addSubview(setCircle(for: forecastStatus, center: forecastStatusPoint, diameter: Constants.smallCircleDiameter))
	}
}

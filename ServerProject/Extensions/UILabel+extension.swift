//
// Created by Artem Neshko on 08.12.2017.
//

import UIKit

extension UILabel {

  func heightThatFitsFor(width: CGFloat) -> CGFloat {
    let size = self.sizeThatFits( CGSize(width: width, height: CGFloat.greatestFiniteMagnitude) )
    return size.height
  }

  func widthThatFitsFor(height: CGFloat) -> CGFloat {
    let size = self.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: height))
    return size.width
  }

  var textWithFade: String? {
    get {
      return self.text
    }
    set {
      UIView.transition(with: self, duration: 0.3, options: .transitionCrossDissolve, animations: { [weak self] in
        self?.text = newValue
       })
    }
  }

  func isTruncated(frameWidth: CGFloat, frameHeight: CGFloat) -> Bool {

    guard let labelText = text else {
      return false
    }

    let labelTextSize = (labelText as NSString).boundingRect(
        with: CGSize(width: frameWidth, height: .greatestFiniteMagnitude),
        options: .usesLineFragmentOrigin,
        attributes: [.font: font],
        context: nil).size

    return labelTextSize.height > frameHeight
  }

}

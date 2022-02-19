import UIKit
extension UIEdgeInsets{
    static func left(_ padding: CGFloat)->UIEdgeInsets{
        .init(top: .zero,
              left: padding,
              bottom: .zero,
              right: .zero)
    }
    static func top(_ padding: CGFloat)->UIEdgeInsets{
        .init(top: padding,
              left: .zero,
              bottom: .zero,
              right: .zero)
    }
    static func right(_ padding: CGFloat)->UIEdgeInsets{
        .init(top: .zero,
              left: .zero,
              bottom: .zero,
              right: padding)
    }
    static func bottom(_ padding: CGFloat)->UIEdgeInsets{
        .init(top: .zero,
              left: .zero,
              bottom: padding,
              right: .zero)
    }
}

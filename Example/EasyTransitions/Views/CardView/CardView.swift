//
//  CardView.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

public final class CardView: UIView, NibOwnerLoadable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var iconTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewAspectRatio: NSLayoutConstraint!
    
    // Delegate
    weak var delegate: CardViewDelegate?
    
    // Layout
    public struct Layout {
        
        // MARK: - Properties
        public let aspectRatio: CGFloat
        public let cornerRadius: CGFloat
        public let topOffset: CGFloat
        public let closeButtonAlpha: CGFloat
        
        // MARK: - Init
        private init(aspectRatio: CGFloat, cornerRadius: CGFloat, topOffset: CGFloat, closeButtonAlpha: CGFloat) {
            self.aspectRatio = aspectRatio
            self.cornerRadius = cornerRadius
            self.topOffset = topOffset
            self.closeButtonAlpha = closeButtonAlpha
        }
        
        // MARK: - Layouts
        public static let collapsed = Layout(aspectRatio: 335/412,
                                             cornerRadius: 13,
                                             topOffset: 20,
                                             closeButtonAlpha: 0)
        
        public static let expanded = Layout(aspectRatio: 375/492,
                                            cornerRadius: 0,
                                            topOffset: 20 + UIWindow.safeAreaTopInset,
                                            closeButtonAlpha: 1)
    }
    
    // MARK: - Init
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadNibContent()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        set(title: "APP OF THE DAY")
        set(layout: .collapsed)
    }

    private func set(title: String) {
        let attributedString = NSMutableAttributedString(string: title)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.8
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle,
                                      value: paragraphStyle,
                                      range: NSMakeRange(0, attributedString.length))
        titleLabel.attributedText = attributedString
    }
    
    public func set(layout: CardView.Layout) {
        imageView.layer.cornerRadius = layout.cornerRadius
        iconTopLayoutConstraint.constant = layout.topOffset
        imageViewAspectRatio = imageViewAspectRatio.setMultiplier(multiplier: layout.aspectRatio)
        closeButton.alpha = layout.closeButtonAlpha
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        delegate?.closeCardView()
    }
}

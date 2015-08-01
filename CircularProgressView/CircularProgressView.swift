//
//  CircularProgressView.swift
//  CircularProgressView
//
//  Created by Sven Bacia on 01/08/15.
//  Copyright © 2015 Sven Bacia. All rights reserved.
//

import UIKit

// MARK: - Line Cap Enum

public enum LineCap {
  case Round, Butt, Square
  
  public func style() -> String {
    switch self {
    case .Round:
      return kCALineCapRound
    case .Butt:
      return kCALineCapButt
    case .Square:
      return kCALineCapSquare
    }
  }
}

@IBDesignable
public final class CircularProgressView: UIView {
  
  // MARK: - Variables
  
  /// Stroke background color
  @IBInspectable public var backgroundShapeColor: UIColor = UIColor(white: 0.9, alpha: 0.5) {
    didSet {
      updateShapes()
    }
  }
  
  /// Progress stroke color
  @IBInspectable public var progressShapeColor: UIColor   = UIColor.blueColor() {
    didSet {
      updateShapes()
    }
  }
  
  /// Line width
  @IBInspectable public var lineWidth: CGFloat = 8.0 {
    didSet {
      updateShapes()
    }
  }
  
  /// The progress shapes line width will be the `line width` minus the `inset`.
  @IBInspectable public var inset: CGFloat = 0.0 {
    didSet {
      updateShapes()
    }
  }

  /// Progress shapes line cap.
  public var lineCap: LineCap = .Round {
    didSet {
      updateShapes()
    }
  }
  
  /// Returns the current progress.
  @IBInspectable public private(set) var progress: CGFloat {
    set {
      progressShape?.strokeEnd = newValue
    }
    get {
      return progressShape.strokeEnd
    }
  }
  
  /// Duration for a complete animation from 0.0 to 1.0.
  public var completeDuration: Double = 2.0
  
  private var backgroundShape: CAShapeLayer!
  private var progressShape: CAShapeLayer!
  
  private var progressAnimation: CABasicAnimation!
  
  // MARK: - Init
  
  public required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  private func setup() {
    
    backgroundShape = CAShapeLayer()
    backgroundShape.fillColor = nil
    backgroundShape.strokeColor = backgroundShapeColor.CGColor
    layer.addSublayer(backgroundShape)
    
    progressShape = CAShapeLayer()
    progressShape.fillColor   = nil
    progressShape.strokeStart = 0.0
    progressShape.strokeEnd   = 0.1
    layer.addSublayer(progressShape)
    
    progressAnimation = CABasicAnimation(keyPath: "strokeEnd")
  }
  
  // MARK: - Progress Animation
  
  public func setProgress(progress: CGFloat, animated: Bool = true) {
    
    if progress > 1.0 {
      return
    }
    
    var start = progressShape.strokeEnd
    if progressShape.animationKeys()?.count > 0 {
      start = progressShape.presentationLayer().strokeEnd
    }
    
    let duration = abs(Double(progress - start)) * completeDuration
    
    progressShape.strokeEnd = progress
    
    if animated {
      progressAnimation.fromValue = start
      progressAnimation.toValue   = progress
      progressAnimation.duration  = duration
      progressShape.addAnimation(progressAnimation, forKey: progressAnimation.keyPath)
    }    
  }
  
  // MARK: - Layout
  
  public override func layoutSubviews() {
    
    super.layoutSubviews()
    
    backgroundShape.frame = bounds
    progressShape.frame   = bounds
    
    let rect = rectForShape()
    backgroundShape.path = pathForShape(rect).CGPath
    progressShape.path   = pathForShape(rect).CGPath

    updateShapes()
  }
  
  private func updateShapes() {
    backgroundShape?.lineWidth  = lineWidth
    backgroundShape.strokeColor = backgroundShapeColor.CGColor
    
    progressShape?.strokeColor = progressShapeColor.CGColor
    progressShape?.lineWidth   = lineWidth - inset
    progressShape?.lineCap     = lineCap.style()
  }
  
  // MARK: - Helper
  
  private func rectForShape() -> CGRect {
    return CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
  }
  
  private func pathForShape(rect: CGRect) -> UIBezierPath {
    return UIBezierPath(arcCenter: CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect)), radius: rect.size.width / 2.0, startAngle: -CGFloat(M_PI_2), endAngle: CGFloat(3 * M_PI / 2.0), clockwise: true)
  }
}

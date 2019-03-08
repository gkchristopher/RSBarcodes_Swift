//
//  RSCornersLayer.swift
//  RSBarcodesSample
//
//  Created by R0CKSTAR on 6/13/14.
//  Copyright (c) 2014 P.D.Q. All rights reserved.
//

import UIKit
import QuartzCore

open class RSCornersLayer: CALayer {
    @objc open var strokeColor = UIColor.green.cgColor
    @objc open var strokeWidth: CGFloat = 2
    @objc open var drawingCornersArray: Array<Array<CGPoint>> = []
    @objc open var cornersArray: [[CGPoint]] = [] {
        willSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }
    
    override open func draw(in ctx: CGContext) {
        objc_sync_enter(self)
        
        ctx.saveGState()
        
        ctx.setShouldAntialias(true)
        ctx.setAllowsAntialiasing(true)
        ctx.setFillColor(UIColor.clear.cgColor)
        ctx.setStrokeColor(self.strokeColor)
        ctx.setLineWidth(self.strokeWidth)
        
        for corners in cornersArray {
            for idx in 0..<corners.count {
                let point = corners[idx]
                if idx == 0 {
                    ctx.move(to: point)
                } else {
                    ctx.addLine(to: point)
                }
            }
            ctx.closePath()
        }

        ctx.drawPath(using: CGPathDrawingMode.fillStroke)
        
        ctx.restoreGState()
        
        objc_sync_exit(self)
    }
}

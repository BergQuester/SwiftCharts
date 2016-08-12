//
//  ChartPointViewBar.swift
//  Examples
//
//  Created by ischuetz on 14/05/15.
//  Copyright (c) 2015 ivanschuetz. All rights reserved.
//

import UIKit

public class ChartPointViewBar: UIView {
    
    let targetFrame: CGRect
    let animDuration: Float
    
    public init(p1: CGPoint, p2: CGPoint, width: CGFloat, bgColor: UIColor? = nil, animDuration: Float = 0.5) {
        
        let (targetFrame, firstFrame): (CGRect, CGRect) = {
            if p1.y - p2.y =~ 0 { // horizontal
                let targetFrame = CGRectMake(p1.x, p1.y - width / 2, p2.x - p1.x, width)
                let initFrame = CGRectMake(targetFrame.origin.x, targetFrame.origin.y, 0, targetFrame.size.height)
                return (targetFrame, initFrame)
                
            } else { // vertical
                let targetFrame = CGRectMake(p1.x - width / 2, p1.y, width, p2.y - p1.y)
                let initFrame = CGRectMake(targetFrame.origin.x, targetFrame.origin.y, targetFrame.size.width, 0)
                return (targetFrame, initFrame)
            }
        }()
        
        self.targetFrame =  targetFrame
        self.animDuration = animDuration
        
        super.init(frame: firstFrame)
        
        self.backgroundColor = bgColor
    }
    
    required public init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func didMoveToSuperview() {
        
        func targetState() {
            frame = targetFrame
            layoutIfNeeded()
        }
        
        if animDuration =~ 0 {
            targetState()
        } else {
            UIView.animateWithDuration(CFTimeInterval(animDuration), delay: 0, options: .CurveEaseOut, animations: {
                targetState()
            }, completion: nil)
        }

    }
}
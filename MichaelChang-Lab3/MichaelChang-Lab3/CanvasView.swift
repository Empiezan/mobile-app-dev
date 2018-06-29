//
//  Canvas.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import Foundation
import UIKit

class CanvasView : UIView {
    
    var paths : [PathView] = [] {
        didSet {
            print("refreshing canvas with \(paths.count) paths")
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func pickColor(color: UIColor) {
        if paths.last != nil {
            paths.last?.setColor(newColor: color)
        }
    }
    
    func undoPath() {
        if !paths.isEmpty {
            paths.removeLast()
            print("removed last path")
        }
        else {
            print("no paths to undo")
        }
        setNeedsDisplay()
    }
    
    func clearCanvas() {
        paths.removeAll()
        print("cleared canvas")
    }
    
    func addPoint(newPoint : CGPoint) {
        guard let path = paths.last else {
            return
        }
        path.addPoint(point: newPoint)
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        for path in paths {
            print("drawing path")
            path.draw()
        }
    }
    
}

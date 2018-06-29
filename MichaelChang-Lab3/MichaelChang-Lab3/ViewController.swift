//
//  ViewController.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var canvasView: CanvasView!
    @IBOutlet weak var lineWidthSlider: UISlider!    
    
    var currPath : PathView?
    var currentColor = UIColor.black
    
    @IBAction func colorPicked(_ sender: Any) {
        if let color = (sender as! UIButton).backgroundColor {
            currentColor = color
        }
    }
    
    @IBAction func undoPath(_ sender: Any) {
        canvasView.undoPath()
    }

    @IBAction func clearCanvas(_ sender: Any) {
        canvasView.clearCanvas()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: canvasView) {
            currPath = PathView(initPoint: touchPoint, lineWidth: CGFloat(lineWidthSlider.value), color: currentColor)
            canvasView.paths.append(currPath!)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: canvasView) {
            if currPath != nil {
                canvasView.addPoint(newPoint: touchPoint)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchPoint = touches.first?.location(in: canvasView) {
            canvasView.addPoint(newPoint: touchPoint)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


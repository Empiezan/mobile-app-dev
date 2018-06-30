//
//  ViewController.swift
//  MichaelChang-Lab3
//
//  Created by labuser on 6/28/18.
//  Copyright © 2018 wustl. All rights reserved.
//
// Credits
// 1. How to take a screenshot of a UIView (https://stackoverflow.com/questions/31582222/swift-take-sceenshot-of-a-uiview)
// 2. How to save a UI Image to Photos library (https://www.hackingwithswift.com/example-code/media/uiimagewritetosavedphotosalbum-how-to-write-to-the-ios-photo-album)
// 3. How to get image from Photos library (https://www.youtube.com/watch?v=uBmqZwA1mxw)
// 4. How to resize an image (https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift)
// 5. How to display image in UI View (https://stackoverflow.com/questions/27049937/how-to-set-a-background-image-in-xcode-using-swift)

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var lineWidthSlider: UISlider!
    
    var currPath : PathView?
    var currentColor = UIColor.black
    
    @IBAction func openPhotoCanvas(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: false, completion: nil)
        }
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        let size = image.size
        let heightRatio  = canvasView.frame.height  / size.height
        let newSize = CGSize(width: size.width * heightRatio,  height: size.height * heightRatio)
        
        let diff = (newSize.width - canvasView.frame.width) / 2
        var rect : CGRect
        if diff > 0 {
            rect = CGRect(x: -diff, y: 0, width: newSize.width, height: canvasView.frame.height)
        }
        else if diff < 0 {
            rect = CGRect(x: diff, y: 0, width: newSize.width, height: canvasView.frame.height)
        }
        else {
            rect = CGRect(x: 0, y: 0, width: canvasView.frame.width, height: canvasView.frame.height)
        }
        
        UIGraphicsBeginImageContextWithOptions(canvasView.frame.size, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            canvasView.clearCanvas()
            canvasView.backgroundColor = UIColor(patternImage: resizeImage(image: image))
            print("Setting Canvas Image")
        }
        else {
            print("Error Setting Canvas Image")
        }
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func saveCanvas(_ sender: Any) {
        let screenShot = takeScreenshot()
        saveScreenshot(screenShot : screenShot)
    }
    
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, UIScreen.main.scale)
        
        canvasView.drawHierarchy(in: canvasView.bounds, afterScreenUpdates: true)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    func saveScreenshot(screenShot : UIImage) {
        UIImageWriteToSavedPhotosAlbum(screenShot, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
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


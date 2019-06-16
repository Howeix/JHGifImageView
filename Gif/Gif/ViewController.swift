//
//  ViewController.swift
//  Gif
//
//  Created by Jack on 2019/6/16.
//  Copyright © 2019 Howeix. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView(frame: UIScreen.main.bounds)
        scrollview.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        return scrollview
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        
        let imageview = UIImageView.JHCreateGIF(imageView: UIImageView(frame: CGRect(x: 0, y: 70, width: 300, height: 300)), imageName: "Gif1", imageExtName: nil)
        imageview.center.x = scrollView.center.x
        scrollView.addSubview(imageview)
    }
}

extension UIImageView {
    static func JHCreateGIF(imageView: UIImageView, imageName: String, imageExtName: String? = nil) -> UIImageView {
        let dataPath = Bundle.main.path(forResource: imageName, ofType: imageExtName ?? ".gif")
        if let source = CGImageSourceCreateWithURL(NSURL(fileURLWithPath: dataPath!) as CFURL, nil){
            let count: size_t = CGImageSourceGetCount(source)
            var allTime: CGFloat = 0
            let imageArray = NSMutableArray()
            let timeArray = NSMutableArray()
            let widthArray = NSMutableArray()
            let heightArray = NSMutableArray()
            for i in 0..<count {
                if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
                    imageArray.add(image)
                    if let info = CGImageSourceCopyPropertiesAtIndex(source, i, nil) {
                        let imageinfo = info as NSDictionary
                        let width = imageinfo.object(forKey: kCGImagePropertyPixelWidth) as! Double
                        let height = imageinfo.object(forKey: kCGImagePropertyPixelHeight) as! Double
                        widthArray.add(NSNumber(floatLiteral: width))
                        heightArray.add(NSNumber(floatLiteral: height))
                        let timeDic = imageinfo.object(forKey: kCGImagePropertyGIFDictionary) as! NSDictionary
                        let time = timeDic.object(forKey: kCGImagePropertyGIFDelayTime) as! CGFloat
                        allTime += time
                        timeArray.add(NSNumber(floatLiteral: Double(time)))
                    }
                }
            }
            let animation = CAKeyframeAnimation(keyPath: "contents")
            let times = NSMutableArray()
            var currentTime: CGFloat = 0
            for i in 0..<imageArray.count {
                times.add(NSNumber(floatLiteral: Double(currentTime / allTime)))
                currentTime += timeArray[i] as! CGFloat
            }
            animation.keyTimes = (times as! [NSNumber])
            animation.values = (imageArray as! [Any])
            animation.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)]
            animation.repeatCount = MAXFLOAT
            animation.duration = CFTimeInterval(allTime)
            imageView.layer.add(animation, forKey: "gifAnimation")
        }
        return imageView
    }
    
}

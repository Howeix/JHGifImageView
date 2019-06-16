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



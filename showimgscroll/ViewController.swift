//
//  ViewController.swift
//  showimgscroll
//
//  Created by Nathaniel Mcdowell on 9/4/19.
//  Copyright © 2019 Nathaniel Mcdowell. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    
    var scrollView: UIScrollView!
    var imageView: UIImageView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "Atl_as_png.png"))
        
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
        scrollView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)
        
        scrollView.delegate = self
     
        
//        scrollView.minimumZoomScale = 0.1
//        scrollView.maximumZoomScale = 4.0
//        scrollView.zoomScale = 1.0
//
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        setZoomScale()
        setupGestureRecognizer()
    }
    
    override func viewWillLayoutSubviews() {
        setZoomScale()
    }
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = scrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        scrollView.minimumZoomScale = min(widthScale, heightScale)
        scrollView.zoomScale = 1.0
    }

}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
      
        let imageViewSize = imageView.frame.size
        let scrollViewSize = scrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}

extension ViewController {

    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(recognizer:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    @objc func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (scrollView.zoomScale > scrollView.minimumZoomScale) {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        }
    }
}

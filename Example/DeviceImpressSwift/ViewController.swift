//
//  ViewController.swift
//  DeviceImpressSwift
//
//  Created by crazyLuobo on 05/06/2026.
//  Copyright (c) 2026 crazyLuobo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let image = UIImage(named: "example.jpg")!
        if let jpegData = imageToJPEGData(image: image, quality: 0.8) {
            // 使用jpegData做进一步处理或保存
        }
    }
    
    func imageToJPEGData(image: UIImage, quality: CGFloat) -> Data? {
        return image.jpegData(compressionQuality: quality)
    }
    
}


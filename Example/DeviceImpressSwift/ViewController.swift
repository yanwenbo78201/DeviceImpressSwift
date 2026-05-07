//
//  ViewController.swift
//  DeviceImpressSwift
//
//  Created by crazyLuobo on 05/06/2026.
//  Copyright (c) 2026 crazyLuobo. All rights reserved.
//

import UIKit
import DeviceImpressSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(SystemService.getDeviceInfo(uuid: ""))
        
    }

}


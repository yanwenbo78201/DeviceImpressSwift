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
        
        ImpressService.compressForUploadKilobyteRange200to600Async(image: UIImage(named: "big.JPEG")!) { result in
            switch result {
            case .success(let success):
                print("压缩成功\(success.base64)")
            case .failure(let failure):
                print("压缩失败")
            }
        }
    
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.navigationController?.pushViewController(ObjcViewController(), animated: true)
    }

}




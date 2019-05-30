//
//  ViewController.swift
//  Timer-74-76
//
//  Created by herry on 26/07/2017.
//  Copyright © 2017 herry. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    
    @IBOutlet weak var expression: NSTextField!
    
    let countDown:Double = 25*60
    var currentSecond:Double = 0
    
    
    var timer:Timer?{
        didSet{
            oldValue?.invalidate()
        }
    }
    
    lazy var formatter:DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute,.second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startAction(_ sender: NSButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updae(_:)), userInfo: nil, repeats: true)
        
        currentSecond = countDown
    }
    
    
    @IBAction func stopAction(_ sender: NSButton) {
        
        timer=nil
    }
    
    func updae(_ sender:Timer) {
        
        expression.stringValue = "\(formatter.string(from: currentSecond)!)"
        currentSecond -= 1
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


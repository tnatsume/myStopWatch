//
//  ViewController.swift
//  myStopWatch
//
//  Created by 夏目　崇 on 2019/04/22.
//  Copyright © 2019年 夏目　崇. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var startTime:TimeInterval? = nil
    var timer = Timer()
    var elapsedTime: Double = 0.0
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var stopFlag: UIButton!
    @IBOutlet weak var resetFlag: UIButton!
    
    @IBOutlet weak var startFlag: UIButton!
    @objc func setBtnEnabled(startFlag:Bool,stopFlag:Bool,resetFlag:Bool){
        self.startFlag.isEnabled = startFlag
        self.stopFlag.isEnabled = stopFlag
        self.resetFlag.isEnabled = resetFlag
    }
    @objc func update(){
        // 2001/1/1 00:00:00
//        print(Date.timeIntervalSinceReferenceDate)
        if let startTime = self.startTime {
            let t: Double = Date.timeIntervalSinceReferenceDate - startTime + elapsedTime

            // 分、秒、ミリ秒の取得
            let min = Int(t / 60)
            let sec = Int(t) % 60
            let msec = Int((t - Double(min*60) - Double(sec)) * 100.0)
            
            
            // 秒数の表示
            self.myLabel.text = String(format:"%02d:%02d:%02d",min,sec,msec)
        }
        
        
    }
    @IBAction func startTimer(_ sender: Any) {
        self.startTime = Date.timeIntervalSinceReferenceDate
        
        self.timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        
        setBtnEnabled(startFlag: false, stopFlag: true, resetFlag: false)
    }
    @IBAction func resetTimer(_ sender: Any) {
        self.startTime = nil
        self.myLabel.text = "00:00:00"
        elapsedTime = 0.0
        setBtnEnabled(startFlag: true, stopFlag: false, resetFlag: false)
    }
    @IBAction func stopTimer(_ sender: Any) {
        if let startTime = self.startTime {
            self.elapsedTime += Date.timeIntervalSinceReferenceDate - startTime
        }
        self.timer.invalidate()
        setBtnEnabled(startFlag: true, stopFlag: false, resetFlag: true)
        //        start :true
        //        stop: false
        //        reset false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setBtnEnabled(startFlag: true, stopFlag: false, resetFlag: false)
        //        start :true
        //        stop: false
        //        reset false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Rohith on 11/03/16.
//  Copyright © 2016 Rohith. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {

    @IBOutlet weak var counterLbl: UILabel!
    var runningNumber = ""
    var operation = ""
    var res = "0"
    var num2 = ""
    var num1 = ""
    var btnSound:AVAudioPlayer!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        counterLbl.text = ""
        do{
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
        }catch let err as NSError
        {
            print(err.debugDescription)
        }
        
    }

    @IBAction func NumberPressed(sender: UIButton!) {
        
        playSound()
        
        if sender.tag == 50 || sender.tag == 60 || sender.tag == 70 || sender.tag == 80{
            if operation == ""{
              decideOperation(sender.tag)
            }else{
                operationsFunc(operation, num: Int(num1)!, tempnum: Int(num2)!)
   
            }
           
        }else{
            
            if operation == ""{
                
                runningNumber += "\(sender.tag)"
                num1 = runningNumber
                counterLbl.text = String(runningNumber)
                
            }else{
              
              
              num2 += "\(sender.tag)"
              counterLbl.text = String(num2)
               
                
            }
        }
        
        
       
    }
    
    
    func decideOperation(num:Int){
        
        switch num{
        case 50 : operation = "add"
        case 60 : operation = "sub"
        case 70 : operation = "div"
        case 80 : operation = "mul"
        default : operation = ""
        }
        
    }
    
   
    func operationsFunc(operation1:String, num:Int, tempnum:Int){
        
      
      counterLbl.text  = performOperation(operation1, num1: num, num2: tempnum)
        runningNumber = counterLbl.text!
        num1 = runningNumber
        num2 = ""
        operation = ""
    }
    
    
    func performOperation(oper:String,num1:Int, num2:Int) -> String{
        
        switch oper{
        case "add" : return String(num1 + num2)
        case "sub" : return String(num1 - num2)
        case "div" :  if num2 == 0{
                        return "0"
                      }else{
                        return String(num1 / num2)
                      }
        case "mul" : return String(num1 * num2)
        default : return ""
        }
        
    }

    @IBAction func AC(sender: AnyObject) {
        
        playSound()
         runningNumber = ""
         operation = ""
         res = ""
         num2 = ""
         counterLbl.text = "0"
        
        
    }
    
    @IBAction func EqualsPressed(sender: AnyObject) {
        
        if operation != ""{
            
            playSound()
            operationsFunc(operation, num: Int(num1)!, tempnum: Int(num2)!)
        }
        
    }
   
    func playSound() {
        
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    
    
}


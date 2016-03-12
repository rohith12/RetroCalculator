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
    var rightNum = ""
    var leftNum = ""
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
            // Used for operations
            if operation == ""{
                //If operation is empty assigns a operation
              decideOperation(sender.tag)
            }else{
                //If operation is assigned performs it when pressing on other operation key
                operationsFunc(operation, num: Int(leftNum)!, tempnum: Int(rightNum)!)
   
            }
           
        }else{
            
            if operation == ""{
              // used to assign LHS of the operator
                runningNumber += "\(sender.tag)"
                leftNum = runningNumber
                counterLbl.text = String(runningNumber)
                
            }else{
              
              // used to assign RHS of the operator
              rightNum += "\(sender.tag)"
              counterLbl.text = String(rightNum)
               
                
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
        leftNum = runningNumber
        rightNum = ""
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
         rightNum = ""
         counterLbl.text = "0"
        
        
    }
    
    @IBAction func EqualsPressed(sender: AnyObject) {
        
        if operation != ""{
            //Equals will only work when operation variable is not empty
            playSound()
            operationsFunc(operation, num: Int(leftNum)!, tempnum: Int(rightNum)!)
        }
        
    }
   
    func playSound() {
        
        if btnSound.playing{
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    
    
    
}


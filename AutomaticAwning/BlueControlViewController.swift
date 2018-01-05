//
//  BlueControlViewController.swift
//  AutomaticAwning
//
//  Created by Pattranit Pisantanaroj on 11/29/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit
import CoreBluetooth

class BlueControlViewController: UIViewController{

    @IBOutlet weak var txtAction: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    
    var myText = ""
    
    @IBAction func buttonClicked(sender: UIButton) {
        if mySwitch.isOn {
            
            mySwitch.setOn(false, animated:true)
        } else {
            
            mySwitch.setOn(true, animated:true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySwitch.addTarget(self, action: Selector(("stateChanged")), for : UIControlEvents.valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            myText = "The Switch is On"
        } else {
            myText = "The Switch is Off"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

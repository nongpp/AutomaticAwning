//
//  AddAwningViewController.swift
//  AutomaticAwning
//
//  Created by Pattranit Pisantanaroj on 11/28/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreData

class AddAwningViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let awningType = ["Indoor", "Outdoor"]
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var pickerViewType: UIPickerView!
    
    @IBAction func saveMethod(_ sender: Any) {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let newAwning = NSEntityDescription.insertNewObject(forEntityName: "AwningTB", into:myContext)
        let myAwningType = awningType[pickerViewType.selectedRow(inComponent: 0)]
        
        newAwning.setValue(txtName.text!, forKey: "awningName")
        newAwning.setValue("\(myAwningType)", forKey: "awningType")
        
        do{
            try myContext.save()
            print("Save")
        }catch{
            print("Cannot save data!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event:UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func cancelMethod(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return awningType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return awningType[row]
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerViewType.selectRow(1, inComponent: 0, animated: true)

        // Do any additional setup after loading the view.
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

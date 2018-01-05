//
//  AwningListTableViewController.swift
//  AutomaticAwning
//
//  Created by Pattranit Pisantanaroj on 11/28/2560 BE.
//  Copyright © 2560 Pattranit Pisantanaroj. All rights reserved.
//

import UIKit
import CoreData

class AwningListTableViewController: UITableViewController {
    var myAwningList : [Awning] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "AutomaticAwning"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myAwningList.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myAwningList.removeAll()
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AwningTB")
        
        do {
            let myFetchResults = try myContext.fetch(myFetchRequest)
            if myFetchResults.count > 0 {
                for myResult in myFetchResults as! [NSManagedObject] {
                    let myAwningName = myResult.value(forKey: "awningName") as! String
                    let myAwningType = myResult.value(forKey: "awningType") as! String
                    let myStudentInfo = Awning(AwningName: myAwningName, AwningType: myAwningType)
                    myAwningList.append(myStudentInfo)
                }
            }
        } catch let error as NSError {
            print (error.description)
        }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AwningTableViewCell

        cell.lblName.text = myAwningList[indexPath.row].AwningName

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let myAppDelegate = UIApplication.shared.delegate as! AppDelegate
        let myContext = myAppDelegate.persistentContainer.viewContext
        
        if editingStyle == .delete {
            let myFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AwningTB")
            myFetchRequest.returnsObjectsAsFaults = false
            let myPredicate = NSPredicate(format: "awningName == %@",myAwningList[indexPath.row].AwningName)
            myFetchRequest.predicate = myPredicate
            
            do{
                let myFetchResults = try myContext.fetch(myFetchRequest)
                if myFetchResults.count > 0 {
                    let myReesult = myFetchResults.first as!NSManagedObject
                    myContext.delete(myReesult)
                }
            } catch let error as NSError {
                print(error.description)
            }
            
            myAwningList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            do{
                try myContext.save()
            } catch let error as NSError {
                print(error.description)
            }
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

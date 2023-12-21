//
//  ViewController.swift
//  WattagePricing
//
//  Created by Tony Barrera on 12/19/23.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var resultLabel: NSTextField!
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var wattField: NSTextField!
    @IBOutlet weak var hourField: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    
    
    
    let manager = ItemManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func addButtonPressed(_ sender: Any) {
        
        // check that the fields are not blank
        if(nameField.stringValue == "" || wattField.stringValue == ""){
            return
        }
        let item = ElectronicItem(name: nameField.stringValue, wattage: wattField.doubleValue, hoursUsedPerDay: hourField.doubleValue)
        manager.add(item: item)
        
        UpdateView()
    }
    
    func UpdateView(){
        resultLabel.stringValue = "Total cost per day: $\(manager.totalDailyUsageCost(pricePerKilowattHour: 0.11))"
        tableView.reloadData()
    }
    
    @IBAction func quitButtonPressed(_ sender: Any) {
        NSApp.terminate(self)
    }
    
    // Table Management
    func numberOfRows(in tableView: NSTableView) -> Int {
        return manager.items.count
    }
    
    func tableView2(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        
        
        print("___________")
        print(tableColumn ?? "no col found?")
        print(tableColumn?.identifier.rawValue ?? "no col found?")
        print("_____________")
        
        let item = manager.items[row]
        switch tableColumn?.identifier.rawValue {
            case "NameColumn":
                return item.name
            case "WattageColumn":
                return item.wattage
            case "HoursColumn":
                return item.hoursUsedPerDay
            default:
                return nil
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""

        let item = manager.items[row]
        print("___________")
        print(tableColumn ?? "no col found?")
        print(tableView.tableColumns[0])
        print("_____________")
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = String(item.wattage)
            cellIdentifier = "WattageCellID"
        } else if tableColumn == tableView.tableColumns[2] {
            text = String(item.hoursUsedPerDay)
            cellIdentifier = "HoursCellID"
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
    }

}

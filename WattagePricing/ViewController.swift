//
//  ViewController.swift
//  WattagePricing
//
//  Created by Tony Barrera on 12/19/23.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var resultLabel: NSTextField!
    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var warningLabel: NSTextField!
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var wattField: NSTextField!
    @IBOutlet weak var hourField: NSTextField!
    @IBOutlet weak var minutesField: NSTextField!
    
    @IBOutlet weak var tableView: NSTableView!
    
    let manager = ItemManager()
    var kwhCost = 0.12
    
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
        
        // TODO: check to see if negative, or zero number
        // check that the fields are not blank
        if(nameField.stringValue.isEmpty ||
           wattField.stringValue.isEmpty ){
            return
        }
        
        // TODO: check that there is at least some time on the fields.
        
        // Protect from going over 24 hours
        if (hourField.doubleValue > 24.0){
            hourField.doubleValue = 24.0
        }
        
        if (minutesField.integerValue > 59){
            minutesField.integerValue = 59
        }
        
        // if we get to a point where the time is invalid, show error to user
        // returns and does not create an ElectronicItem.
        if (hourField.doubleValue >= 24 && minutesField.integerValue > 0){
            warningLabel.stringValue = "Invalid Hours & Minutes"
            UpdateView()
            return
        }
        
        let item = ElectronicItem(
            name: nameField.stringValue,
            wattage: wattField.doubleValue,
            hoursUsedPerDay: hourField.doubleValue,
            minutesPerDay: minutesField.integerValue)
        manager.add(item: item)
        
        // Clear the fields and Warning Label.
        nameField.stringValue = ""
        wattField.stringValue = ""
        hourField.stringValue = ""
        minutesField.stringValue = ""
        warningLabel.stringValue = ""
        
        UpdateView()
    }
    
    func UpdateView(){
        
        // updates the running total label based on what the manager has in the collection.
        let dailyCost: Double = manager.totalDailyUsageCost(pricePerKilowattHour: kwhCost)
        let dailyFormat: String = String(format: "$%.2f", dailyCost)
        let monthlyCost: Double = manager.totalmonthlyUsageCost(pricePerKilowattHour: kwhCost)
        let monthlyFormat: String = String(format: "$%.2f", monthlyCost)

        resultLabel.stringValue = "Total cost per day: " + dailyFormat + " | per month: " + monthlyFormat
        tableView.reloadData()
    }
    
    @IBAction func quitButtonPressed(_ sender: Any) {
        NSApp.terminate(self)
    }
    
    // Table Management
    func numberOfRows(in tableView: NSTableView) -> Int {
        return manager.items.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var text: String = ""
        var cellIdentifier: String = ""
        let item = manager.items[row]
        
        if tableColumn == tableView.tableColumns[0] {
            text = item.name
            cellIdentifier = "NameCellID"
        } else if tableColumn == tableView.tableColumns[1] {
            text = String(item.wattage)
            cellIdentifier = "WattageCellID"
        } else if tableColumn == tableView.tableColumns[2] {
            text = String(format: "%.1f", item.timeUsedInHours())
            cellIdentifier = "HoursCellID"
        } else if tableColumn == tableView.tableColumns[3] {
            let dailyCost: Double = item.dailyCost(pricePerKilowattHour: kwhCost)
            text = String(format: "$%.2f", dailyCost)
            cellIdentifier = "DailyCellID"
        } else if tableColumn == tableView.tableColumns[4] {
            let monthlyCost: Double = item.monthlyCost(pricePerKilowattHour: kwhCost)
            text = String(format: "$%.2f", monthlyCost)
            cellIdentifier = "MonthlyCellID"
        }

        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = text
            return cell
        }
        
        return nil
    }

}

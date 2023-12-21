//
//  ElectronicItem.swift
//  WattagePricing
//
//  Created by Tony Barrera on 12/19/23.
//

import Foundation

class ElectronicItem {
    var name: String
    var wattage: Double
    var hoursUsedPerDay: Double
    
    init(name: String, wattage: Double, hoursUsedPerDay: Double) {
        self.name = name
        self.wattage = wattage
        self.hoursUsedPerDay = hoursUsedPerDay
    }
    
    func dailyCost(pricePerKilowattHour: Double) -> Double {
        let dailyConsumption = wattage * hoursUsedPerDay / 1000
        let costPerDay = dailyConsumption * pricePerKilowattHour
        return costPerDay
    }
    
    func monthlyCost(pricePerKilowattHour: Double) -> Double {
        return dailyCost(pricePerKilowattHour: pricePerKilowattHour) * 30
    }
}

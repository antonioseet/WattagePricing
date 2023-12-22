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
    var minutesPerDay: Int
    
    init(name: String, wattage: Double, hoursUsedPerDay: Double, minutesPerDay: Int) {
        self.name = name
        self.wattage = wattage
        self.hoursUsedPerDay = hoursUsedPerDay
        self.minutesPerDay = minutesPerDay
    }
    
    func dailyCost(pricePerKilowattHour: Double) -> Double {
        let minutes = Double(minutesPerDay) / 60
        let dailyConsumption = wattage * (hoursUsedPerDay + minutes) / 1000
        let costPerDay = dailyConsumption * pricePerKilowattHour
        return costPerDay
    }
    
    func monthlyCost(pricePerKilowattHour: Double) -> Double {
        return dailyCost(pricePerKilowattHour: pricePerKilowattHour) * 30
    }
    
    func timeUsedInHours() -> Double{
        return hoursUsedPerDay + (Double(minutesPerDay) / 60)
    }
}

//
//  ItemManager.swift
//  WattagePricing
//
//  Created by Tony Barrera on 12/19/23.
//

import Foundation

class ItemManager {
    var items: [ElectronicItem] = []
    
    func add(item: ElectronicItem) {
        items.append(item)
    }
    
    func totalDailyUsageCost(pricePerKilowattHour: Double) -> Double {
        var totalCost: Double = 0.0
        
        for item in items{
            totalCost += item.dailyCost(pricePerKilowattHour: pricePerKilowattHour)
        }
                
        return totalCost
    }
    
    func totalmonthlyUsageCost(pricePerKilowattHour: Double) -> Double {
        return totalDailyUsageCost(pricePerKilowattHour: pricePerKilowattHour) * 30
    }
}

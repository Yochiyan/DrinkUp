import Foundation

extension DrinkRecord {
    // Save a single water entry to HealthKit. Amount is in milliliters.
    static func saveWater(amountML: Double, date: Date) async throws {
        // Delegate to HealthKitManager; ignore errors for now for simplicity.
        // If desired, expand to check authorization and propagate errors.
        let record = DrinkRecord(date: date, amount: Int(amountML))
        await HealthKitManager.shared.syncAll(records: [record])
    }
}

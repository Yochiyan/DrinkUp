/*import Foundation
import HealthKit

final class HealthKitManager {
    static let shared = HealthKitManager()

    private let healthStore = HKHealthStore()

    private init() {}

    // Check if HealthKit is available on this device
    func isAvailable() -> Bool {
        return HKHealthStore.isHealthDataAvailable()
    }

    // Request authorization to read/write water data
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard isAvailable() else {
            completion(false)
            return
        }

        let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater)!
        let toShare: Set<HKSampleType> = [waterType]
        let toRead: Set<HKObjectType> = [waterType]

        healthStore.requestAuthorization(toShare: toShare, read: toRead) { success, _ in
            completion(success)
        }
    }

    // Sync all drink records to HealthKit (no-op if not authorized)
    func syncAll(records: [DrinkRecord]) async {
        let waterType = HKObjectType.quantityType(forIdentifier: .dietaryWater)!
        for record in records {
            let quantity = HKQuantity(unit: .literUnit(with: .milli), doubleValue: Double(record.amount))
            let sample = HKQuantitySample(type: waterType, quantity: quantity, start: record.date, end: record.date)
            await withCheckedContinuation { continuation in
                healthStore.save(sample) { _, _ in
                    continuation.resume()
                }
            }
        }
    }
}
*/

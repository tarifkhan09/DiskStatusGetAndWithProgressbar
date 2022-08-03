//
//  DiskStatus.swift
//  DiskStatusGetAndWithProgressbar
//
//  Created by MD Tarif khan on 3/8/22.
//
import UIKit

class DiskStatus {
    //MARK: Get String Value
    class var totalDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: totalDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    class var freeDiskSpace:String {
        get {
            
            return ByteCountFormatter.string(fromByteCount: freeDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    class var usedDiskSpace:String {
        get {
            return ByteCountFormatter.string(fromByteCount: usedDiskSpaceInBytes, countStyle: ByteCountFormatter.CountStyle.file)
        }
    }
    
    
    //MARK: Get raw value
    class var totalDiskSpaceInBytes:Int64 {
        get {
            do {
                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
                let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value
                return space!
            } catch {
                return 0
            }
        }
    }
    
    class var  freeDiskSpaceInBytes:Int64 {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            let capacity = values.volumeAvailableCapacityForImportantUsage
            return Int64(capacity ?? 0)
        } catch {
            return 0
        }
    }
    

    
    class var usedDiskSpaceInBytes:Int64 {
        get {
            let usedSpace = totalDiskSpaceInBytes - freeDiskSpaceInBytes
            return usedSpace
        }
    }
    
}





//    func totalDiskSpaceInBytes() -> UInt64 {
//        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
//        do {
//            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
//            let capacity = values.volumeTotalCapacity
//            return UInt64(capacity ?? 0)
//        } catch {
//            return 0
//        }
//    }
////    class var freeDiskSpaceInBytes:Int64 {
//        get {
//            do {
//                let systemAttributes = try FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String)
//                let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value
//                return freeSpace!
//            } catch {
//                return 0
//            }
//        }
//    }

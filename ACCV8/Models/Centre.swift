//
//  Centre.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift
import MapKit

class Centre: Object, ObjectKeyIdentifiable {
    @Persisted var _id: ObjectId
    @Persisted var centreName = ""
    @Persisted var centreDesc = ""
    @Persisted var centreLocation: CLLocationCoordinate2D
    @Persisted var centreIndex = 0
    @Persisted var centreText = ""
    @Persisted var centreImage: Data?
    @Persisted var centreBackgrnd = ""
    @Persisted var centreLogoF = ""
    
    override static func primaryKey() -> String? {
          return "_id"
      }
  
    convenience init(centreName: String, centreDesc: String, centreIndex: Int, centreText: String, centreImage: Data?, centreBackgrnd: String, centreLogoF: String) {
        self.init()
        self.centreName = centreName
        self.centreDesc = centreDesc
        self.centreIndex = centreIndex
        self.centreText = centreText
        self.centreImage = centreImage
        self.centreBackgrnd = centreBackgrnd
        self.centreLogoF = centreLogoF
     }
//    var coordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(latitude: (centreLocation?.y)!, longitude: (centreLocation?.x)!)
//        }
}
extension CLLocationCoordinate2D: CustomPersistable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.longitude == rhs.longitude &&
                lhs.latitude == rhs.latitude
    }
    public typealias PersistedType = Coordinates
    public init(persistedValue: PersistedType) {
        self.init(latitude: persistedValue.latitude, longitude: persistedValue.longitude)
    }
    public var persistableValue: PersistedType {
        Coordinates(value: [self.latitude, self.longitude])
    }
}


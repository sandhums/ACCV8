//
//  Coordinates.swift
//  ACCV8
//
//  Created by Manjinder Sandhu on 29/06/22.
//

import Foundation
import RealmSwift

public class Coordinates: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var latitude: Double
    @Persisted var longitude: Double
}

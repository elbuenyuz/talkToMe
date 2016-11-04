//
//  dataService.swift
//  talkToMe
//
//  Created by Daniel Ramirez on 11/1/16.
//  Copyright © 2016 simpleCoding. All rights reserved.
//
/*
 DataService esta clase contendra la conexion con firebase
 */
import Foundation
import FirebaseDatabase
import Firebase


class DataService{
    //servicio de informacion
    static let ds = DataService()
    
    //creamos una referencia de la urlBase
    private var _REF_BASE = FIRDatabase.database().referenceFromURL("talktome-d9fe0.firebaseio.com")
    //constructor de la baseUrl
    var REF_BASE: FIRDatabaseReference{
        return _REF_BASE
    }

}
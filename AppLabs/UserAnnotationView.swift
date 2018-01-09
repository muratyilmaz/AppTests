//
//  UserAnnotationView.swift
//  AppLabs
//
//  Created by test on 09/01/2018.
//  Copyright © 2018 Grey. All rights reserved.
//

import UIKit
import MapKit

class UserAnnotationView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.red
    }
}

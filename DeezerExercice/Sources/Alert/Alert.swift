//
//  Alert.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 20/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

enum AlertType: Equatable {
    case networkError
}

struct Alert: Equatable {
    let title: String
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(title: "Alert", message: "A very very bad thing happened.. 🙈")
        }
    }
}

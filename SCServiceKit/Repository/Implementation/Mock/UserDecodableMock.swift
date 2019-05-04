//
// Created by Scott Moon on 2019-05-05.
// Copyright (c) 2019 Scott Moon. All rights reserved.
//

import Foundation

struct UserDecodableMock: Decodable {
	let args: UserDecodableChildMock
}

struct UserDecodableChildMock: Decodable {
  let name, surname, age: String
}

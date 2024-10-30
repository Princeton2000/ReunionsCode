//
//  FontFamily.swift
//  IgniteStarter
//
//  Created by Justin Purnell on 8/20/24.
//

import Foundation
import Ignite

extension Script {
	
	/// Embeds some custom, inline JavaScript on this page.
	public init(string: String) {
		self.init(code: string)
	}
	
	func renderString(_ string: String) -> String {
		return string
	}
}

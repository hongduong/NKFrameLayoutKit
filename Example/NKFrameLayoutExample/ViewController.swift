//
//  ViewController.swift
//  NKFrameLayoutExample
//
//  Created by Nam Kennic on 7/3/17.
//  Copyright © 2017 kennic. All rights reserved.
//

import UIKit
import NKFrameLayoutKit

class ViewController: UIViewController {
	let testView = TestView()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.view.addSubview(testView)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		let viewSize = self.view.bounds.size
		let testViewSize = testView.sizeThatFits(viewSize)
		testView.frame = CGRect(x: (viewSize.width - testViewSize.width)/2, y: (viewSize.height - testViewSize.height)/2, width: testViewSize.width, height: testViewSize.height) // đưa testView vào giữa màn hình
	}


}

/*
Class này hướng dẫn cách dùng NKDoubleFrameView để tạo layout cho 2 view bất kỳ theo chiều ngang hoặc dọc
Tóm tắt các bước khởi tạo:
- Tạo các view cần hiển thị trước, đưa chúng (addSubview:) vào view chính
- Khởi tạo NKDoubleFrameLayout với direction mong muốn (ngang hoặc dọc), kèm với 2 view cần layout
- Thay đổi thông số frameLayout nếu cần
- Đưa frameLayout vào view chính (addSubview:frameLayout)
*/
class TestView: UIView {
	let label1 = UILabel()
	let label2 = UILabel()
	var frameLayout : NKDoubleFrameLayout!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		label1.font = UIFont(name: "Helvetica", size: 30)
		label2.font = UIFont(name: "Helvetica", size: 15)
		
		label1.text = "NKDoubleFrameLayout"
		label2.text = "Dùng NKDoubleFrameLayout để layout 2 view bất kỳ theo chiều ngang (.horizontal) hoặc dọc (.vertical)"
		label2.numberOfLines = 0
		
		self.addSubview(label1)
		self.addSubview(label2)
		
		frameLayout = NKDoubleFrameLayout(direction: .vertical, andViews: [label1, label2]) // khởi tạo layout theo chiều dọc, và gán vào 2 view label1 & label2. Thử thay đổi thành .horizontal để xem thay đổi ra sao
		
		/* // Hoặc cách khởi tạo từng dòng (có thể dùng để thay thế target view khác nếu cần)
		frameLayout = NKDoubleFrameLayout(direction: .vertical)
		frameLayout.topFrameLayout.targetView = label1; // gán label1 vào phần layout phía trên
		frameLayout.bottomFrameLayout.targetView = label2; // gán label2 vào phần layout phía dưới
		*/
		
		// các dòng dưới đây là ví dụ việc thay đổi các thông số
//		frameLayout.topFrameLayout.minSize = CGSize(width: 0, height: 80)		// set chiều cao tối thiểu của phần label1 phía trên là 80px (width:0 nghĩa là không set giá trị)
//		frameLayout.bottomFrameLayout.maxSize = CGSize(width: 0, height: 100)	// set chiều cao tối đa của phần label2 phía dưới là 100px
		
		frameLayout.spacing = 10.0 // khoảng trống giữa 2 view
		frameLayout.edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) // thêm khoảng trống vào 4 cạnh xung quanh nếu cần
		frameLayout.showFrameDebug = true // hiển thị các gạch ranh giới để debug
		
		self.addSubview(frameLayout)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		frameLayout.frame = self.bounds
	}
	
	override func sizeThatFits(_ size: CGSize) -> CGSize {
		return frameLayout.sizeThatFits(size)
	}
	
}

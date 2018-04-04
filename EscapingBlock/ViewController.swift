//
//  ViewController.swift
//  EscapingBlock
//
//  Created by 陈吉 on 2018/4/4.
//  Copyright © 2018年 陈吉. All rights reserved.
//

import UIKit

//逃逸闭包：当函数执行结束后，才去调用函数内部的闭包，叫做逃逸闭包
//非逃逸闭包：当函数执行过程中，执行的函数内部的闭包，叫做非逃逸闭包

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.loadData { (json : [String]) in
            print(json)
        }
        
        self.setupUI { (result) in
            print(result)
        }
    }
    
    fileprivate func loadData(completion:@escaping (_ : [String]) -> ()) {
    
        DispatchQueue.global().async {
            print("当前的线程\(Thread.current)")
            Thread.sleep(forTimeInterval: 3)
            let json = ["chenji"]
            DispatchQueue.main.async {
                print("当前的线程\(Thread.current)")
                completion(json)
            }
            print("执行到这儿结束了") //函数结束后才去调用的闭包就是逃逸闭包
        }
    }
    
    fileprivate func setupUI(completion: (_ : [String]) -> ()) {
        //这个是非逃逸闭包
        let json = ["chenji1", "chenji2", "chenji3"]
        completion(json)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


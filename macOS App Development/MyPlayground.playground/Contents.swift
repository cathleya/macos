//: Playground - noun: a place where people can play

import UIKit

var arr = [7,4,11,3,5,2,6,9,13,10,8]

//MARK: -- Bubble sort

for x in 0..<arr.count {
    for i in 0 ..< arr.count-x-1  {
        if arr[i]>arr[i+1] {
            var temp = arr[i]
            arr[i] = arr[i+1]
            arr[i+1] = temp
        }
    }
}

arr

//MARK: -- Two point lookup method

let god = [5,8,14,20,31,55,78,81,93,97,111]
let zeous = 93
var times = 0

var left = 0
var right = god.count
var middle = 0
while right >= left {
    middle = (left+right)/2
    if god[middle] == zeous {
        middle
        break
    }
    if god[middle] > zeous {
        right = middle-1
    }
    if god[middle] < zeous {
        left = middle+1
    }
}
middle
times


//MARK: -- 二叉树

class BinaryTreeNote{
    
    var value:String
    var leftChild:BinaryTreeNote?
    var rightChild:BinaryTreeNote?
    
    init(_ value:String) {
        self.value = value
    }
    
}


class BinaryTreeHelper{
    
    var array:[String]
    var index = -1
    
    init(_ array:[String]) {
        self.array = array
    }
    
    //创建二叉树
    func createTree() -> BinaryTreeNote? {
        
        self.index = self.index + 1
        if index < self.array.count && index >= 0 {
            
            let value = self.array[index]
            
            if value == "" {
                return nil
            } else {
                let note = BinaryTreeNote(value)
                note.leftChild = createTree()
                note.rightChild = createTree()
                return note
            }
        }
        return nil;
    }
    
    //先序遍历二叉树
    func preOrderTraverse(_ note:BinaryTreeNote?){
        if note == nil {
            print("#")
            return
        }
        print(note!.value)
        preOrderTraverse(note!.leftChild)
        preOrderTraverse(note!.rightChild)
    }
    
    //中序遍历二叉树
    func inOrderTraverse (_ note: BinaryTreeNote?) {
        if note == nil {
            print("#")
            return
        }
        inOrderTraverse(note!.leftChild)
        print(note!.value)
        inOrderTraverse(note!.rightChild)
    }
    
    //后序遍历二叉树
    func afterOrderTraverse (_ note: BinaryTreeNote?) {
        if note == nil {
            print("#")
            return
        }
        afterOrderTraverse(note!.leftChild)
        afterOrderTraverse(note!.rightChild)
        print(note!.value)
    }
    
    //层次遍历二叉树
    func levelOrder(_ root: BinaryTreeNote?){
        
        var result = [[BinaryTreeNote]]()
        var level = [BinaryTreeNote]()
        
        level.append(root!)
        while level.count != 0 {
            result.append(level)
            var nextLevel = [BinaryTreeNote]()
            for node in level {
                if let leftNode = node.leftChild {
                    nextLevel.append(leftNode)
                }
                if let rightNode = node.rightChild {
                    nextLevel.append(rightNode)
                }
            }
            level = nextLevel
        }
        
        let ans = result.map { $0.map { $0.value }}
        print(ans)
    }
    
    //翻转二叉树
    func invertTree(_ root:BinaryTreeNote?) -> BinaryTreeNote? {
        if root == nil {
            return nil
        }
        
        root?.leftChild = invertTree (root?.leftChild);

        root?.rightChild = invertTree (root?.rightChild);
        
        let tmp = root?.leftChild;
        
        root?.leftChild = root?.rightChild;
    
        root?.rightChild = tmp;

        return root;

    }
    
    
}

let ele = BinaryTreeHelper(["A","B","C","D","E","F","G"])
let node = ele.createTree()
//ele.preOrderTraverse(node)

let newtree = ele.invertTree(node)

ele.preOrderTraverse(newtree)








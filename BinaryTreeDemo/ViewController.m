//
//  ViewController.m
//  test
//
//  Created by LiaoQiang on 2019/2/25.
//  Copyright © 2019年 LiaoQiang. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSArray *values = @[@"6",@"2",@"3",@"4",@"5",@"11",@"7",@"9",@"8",@"10",@"20",@"1"];
    
    BinaryTreeNode *rootNode = nil;
    for (NSString *value in values) {
        rootNode = [self addTreeNode:rootNode value:value.integerValue];
    }
    NSLog(@"%@",rootNode.description);
    [self preOrderTraverseTree:rootNode handler:nil];
    NSLog(@"广度优先遍历");
    [self levelTraverseTree:rootNode];
    NSLog(@"二叉树深度");
    NSLog(@"%ld",[self depthOfTree:rootNode]);
    
    [self convertBinaryTree:rootNode];
    NSLog(@"翻转后的二叉树先序遍历");
    [self preOrderTraverseTree:rootNode handler:nil];
    
}

//创建二叉树
- (BinaryTreeNode *)addTreeNode:(BinaryTreeNode *)treeNode value:(NSInteger)value {
    if (treeNode == nil) {
        treeNode = BinaryTreeNode.new;
        treeNode.value = value;
    }
    else {
        if (value>treeNode.value) {
            treeNode.rightNode = [self addTreeNode:treeNode.rightNode value:value];
        }
        else {
            treeNode.leftNode = [self addTreeNode:treeNode.leftNode value:value];
        }
    }
    return treeNode;
}

//先序遍历 根-左-右
- (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        /*先序，中序，后续，分别调整下面几个位置即可*/
        //根
        NSLog(@"%ld",rootNode.value);
        //左
        [self preOrderTraverseTree:rootNode.leftNode handler:handler];
        //右
        [self preOrderTraverseTree:rootNode.rightNode handler:handler];
    }
}

//翻转二叉树
- (void)convertBinaryTree:(BinaryTreeNode *)rootNode {
    if (rootNode) {
        BinaryTreeNode *node = rootNode.leftNode;
        rootNode.leftNode = rootNode.rightNode;
        rootNode.rightNode = node;
        
        [self convertBinaryTree:rootNode.leftNode];
        [self convertBinaryTree:rootNode.rightNode];
    }
}

//广度优先遍历，先上后下，先左后右
- (void)levelTraverseTree:(BinaryTreeNode *)rootNode {
    if (rootNode) {
        NSMutableArray<BinaryTreeNode *> *nodes = [NSMutableArray array];
        [nodes addObject:rootNode];
        while (nodes.count>0) {
            NSLog(@"%ld",nodes.firstObject.value);
            BinaryTreeNode *node = nodes.firstObject;
            [nodes removeObjectAtIndex:0];
            if(node.leftNode)[nodes addObject:node.leftNode];
            if(node.rightNode)[nodes addObject:node.rightNode];
        }
    }
}

//二叉树深度
- (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    //左子树深度
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    //右子树深度
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}

@end


@implementation BinaryTreeNode

- (NSString *)description {
    return [NSString stringWithFormat:@"value:%ld,left:%@,right:%@",self.value,self.leftNode.description,self.rightNode.description];
}
@end

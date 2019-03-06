//
//  ViewController.h
//  test
//
//  Created by LiaoQiang on 2019/2/25.
//  Copyright © 2019年 LiaoQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


@interface BinaryTreeNode : NSObject

/**
 *  值
 */
@property (nonatomic, assign) NSInteger value;
/**
 *  左节点
 */
@property (nonatomic, strong) BinaryTreeNode *leftNode;
/**
 *  右节点
 */
@property (nonatomic, strong) BinaryTreeNode *rightNode;

@end

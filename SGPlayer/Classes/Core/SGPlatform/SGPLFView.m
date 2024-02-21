//
//  SGPLFView.m
//  SGPlatform
//
//  Created by Single on 2017/2/24.
//  Copyright © 2017年 single. All rights reserved.
//

#import "SGPLFView.h"
#import "SGPLFScreen.h"

void SGPLFViewSetBackgroundColor(SGPLFView *view, SGPLFColor *color)
{
    view.backgroundColor = color;
}

void SGPLFViewInsertSubview(SGPLFView *superView, SGPLFView *subView, NSInteger index)
{
    [superView insertSubview:subView atIndex:index];
}

SGPLFImage * SGPLFViewGetCurrentSnapshot(SGPLFView *view)
{
    CGSize size = CGSizeMake(view.bounds.size.width * SGPLFScreenGetScale(),
                             view.bounds.size.height * SGPLFScreenGetScale());
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [view drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    SGPLFImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


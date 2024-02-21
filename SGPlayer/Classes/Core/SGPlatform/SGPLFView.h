//
//  SGPLFView.h
//  SGPlatform
//
//  Created by Single on 2017/2/24.
//  Copyright © 2017年 single. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGPLFImage.h"
#import "SGPLFColor.h"

typedef UIView SGPLFView;

void SGPLFViewSetBackgroundColor(SGPLFView *view, SGPLFColor *color);
void SGPLFViewInsertSubview(SGPLFView *superView, SGPLFView *subView, NSInteger index);

SGPLFImage * SGPLFViewGetCurrentSnapshot(SGPLFView *view);

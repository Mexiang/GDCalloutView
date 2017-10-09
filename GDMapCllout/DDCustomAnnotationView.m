//
//  DDCustomAnnotationView.m
//  DingDing
//
//  Created by Dry on 2017/6/13.
//  Copyright © 2017年 ddtech. All rights reserved.
//

#import "DDCustomAnnotationView.h"

#define kCalloutWidth       120.0
#define kCalloutHeight      45.0


@interface DDCustomAnnotationView ()

@end

@implementation DDCustomAnnotationView


- (id)initWithAnnotation:(id<MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier])
    {
        
        [self setUpClloutView];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        [self setUpClloutView];
    }
    else
    {
        
    }
    
    [super setSelected:selected animated:animated];
}

- (void)setUpClloutView {
    if (self.calloutView == nil)
    {
        self.calloutView = [[DDCustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
        self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                              -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        
        [self addSubview:self.calloutView];
    }
}

@end

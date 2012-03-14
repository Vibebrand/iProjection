//
//  CeldaModelo3D.m
//  projectionExample
//
//  Created by Jesus Cagide on 13/03/12.
//  Copyright (c) 2012 INEGI. All rights reserved.
//

#import "CeldaModelo3D.h"

@implementation CeldaModelo3D

@synthesize imagen;

-(void)dealloc
{
    self.imagen= nil;
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end

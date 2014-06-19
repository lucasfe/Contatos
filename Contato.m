//
//  Contato.m
//  Contatos
//
//  Created by ios4357 on 18/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import "Contato.h"

@implementation Contato

-(NSString*)description {

    return [NSString stringWithFormat: @"%@ < %@ >", self.nome, self.email];
}

@end

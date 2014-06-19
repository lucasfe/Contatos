//
//  Contato.h
//  Contatos
//
//  Created by ios4357 on 18/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contato : NSObject

@property (strong, atomic) NSString* nome;
@property (strong, atomic) NSString* telefone;
@property (strong, atomic) NSString* email;
@property (strong, atomic) NSString* endereco;
@property (strong, atomic) NSString* site;

@end

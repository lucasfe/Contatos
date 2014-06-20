//
//  ListaContatosViewController.m
//  Contatos
//
//  Created by ios4357 on 19/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import "ListaContatosViewController.h"

@implementation ListaContatosViewController

-(id)init {
    self = [super init];
    if(self) {
        self.title = @"Contatos";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm:)];
        self.navigationItem.rightBarButtonItem = btn;
    }
    return self;
}


-(void)exibeForm:(id)sender {

    FormularioContatoViewController* form = [[FormularioContatoViewController alloc] init];
    form.contatos = self.contatos;
    
    [self.navigationController pushViewController:form animated:YES];
    //[self presentViewController:form animated:YES completion:nil];
    
}

@end

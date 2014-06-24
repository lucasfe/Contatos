//
//  ListaContatosViewController.h
//  Contatos
//
//  Created by ios4357 on 19/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormularioContatoViewController.h"

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate>

@property (weak, atomic) NSMutableArray *contatos;


-(void)contatoAdicionado:(Contato*)contato;

@end

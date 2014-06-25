//
//  ListaContatosViewController.h
//  Contatos
//
//  Created by ios4357 on 19/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormularioContatoViewController.h"
#import <MessageUI/MessageUI.h>

@interface ListaContatosViewController : UITableViewController <FormularioContatoViewControllerDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {

    Contato * contatoSelecionado;

}


@property (weak, atomic) NSMutableArray *contatos;

@property (atomic) NSInteger linhaSelecionada;

-(void)contatoAdicionado:(Contato*)contato;
-(void)contatoAlterado:(Contato *)contato;

-(void)exibeMaisAcoes:(UILongPressGestureRecognizer *) gestureRecognizer;

@end

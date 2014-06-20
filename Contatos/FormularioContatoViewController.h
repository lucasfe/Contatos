//
//  FormularioContatoViewController.h
//  Contatos
//
//  Created by ios4357 on 18/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contato.h"

@interface FormularioContatoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *site;
@property (weak, nonatomic) IBOutlet UITextField *endereco;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telefone;
@property (weak, nonatomic) IBOutlet UITextField *nome;

@property (strong, atomic) NSMutableArray *contatos;

- (Contato*)pegaDadosDoFormulario;
- (IBAction)proximoCampo:(UITextField*)campoAtual;
-(void)criaContato;



@end

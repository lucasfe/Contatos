//
//  FormularioContatoViewController.m
//  Contatos
//
//  Created by ios4357 on 18/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import "FormularioContatoViewController.h"

@interface FormularioContatoViewController ()

@end

@implementation FormularioContatoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"Cadastro";
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato)];
        self.navigationItem.rightBarButtonItem = btn;
    }
    return self;
}

-(id)initWithContato:(Contato *)umContato {
    
    self = [super init];
    if(self) {
        self.contato = umContato;
        UIBarButtonItem *confirmar = [[UIBarButtonItem alloc] initWithTitle:@"Confirmar" style:UIBarButtonItemStylePlain target:self action:@selector(atualizaContato)];
        self.navigationItem.rightBarButtonItem = confirmar;
    }
    return self;
}

- (void)viewDidLoad
{
    if (self.contato) {
        self.nome.text = self.contato.nome;
        self.telefone.text = self.contato.telefone;
        self.email.text = self.contato.email;
        self.endereco.text = self.contato.endereco;
        self.site.text = self.contato.site;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Contato*)pegaDadosDoFormulario {
    
//    NSMutableDictionary *contato =[[NSMutableDictionary alloc] init ];
//    [contato setObject: self.nome.text forKey:@"nome"];
//    [contato setObject: self.telefone.text forKey:@"telefone"];
//    [contato setObject: self.email.text forKey:@"email"];
//    [contato setObject: self.endereco.text forKey:@"endereco"];
//    [contato setObject: self.site.text forKey:@"site"];
    
    if(!self.contato) {
        self.contato = [[Contato alloc] init];
    }

    self.contato.nome = self.nome.text;
    self.contato.email = self.email.text;
    self.contato.telefone = self.telefone.text;
    self.contato.endereco = self.endereco.text;
    self.contato.site = self.site.text;
    
    return self.contato;
    //NSLog(@"Contato adicionado: %@", (NSString*)[contato objectForKey: @"nome"]);
    
    
}

-(void)criaContato {
    [self.delegate contatoAdicionado:[self pegaDadosDoFormulario]];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) atualizaContato {

    [self pegaDadosDoFormulario];
    if ([self.delegate respondsToSelector:@selector(contatoAlterado:)]) {
        [self.delegate contatoAlterado:self.contato];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)proximoCampo:(UITextField*)campoAtual {

    NSInteger proximaTag = campoAtual.tag + 1;
    UIResponder* proximoCampo =   [self.view viewWithTag:proximaTag];
    
    if (proximoCampo != nil) {
        [proximoCampo becomeFirstResponder];
    }
    else {
        [campoAtual resignFirstResponder];
    }
}
@end

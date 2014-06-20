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
        self.contatos = [[NSMutableArray alloc] init];
        self.navigationItem.title=@"Cadastro";
        UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithTitle:@"Adicionar" style:UIBarButtonItemStylePlain target:self action:@selector(criaContato:)];
        self.navigationItem.rightBarButtonItem = btn;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    
    
    Contato *contato = [[Contato alloc] init];
    contato.nome = self.nome.text;
    contato.email = self.email.text;
    contato.telefone = self.telefone.text;
    contato.endereco = self.endereco.text;
    contato.site = self.site.text;
    
    return contato;
    //NSLog(@"Contato adicionado: %@", (NSString*)[contato objectForKey: @"nome"]);
    
    
}


-(void)criaContato {

    Contato *contato = [self pegaDadosDoFormulario];
    [self.contatos addObject:contato];
    NSLog(@"Contatos Array: %@", self.contatos);
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

//
//  ListaContatosViewController.m
//  Contatos
//
//  Created by ios4357 on 19/06/14.
//  Copyright (c) 2014 lgrmobile. All rights reserved.
//

#import "ListaContatosViewController.h"
#import "FormularioContatoViewController.h"

@implementation ListaContatosViewController

-(id)init {
    self = [super init];
    if(self) {
        self.title = @"Contatos";
        UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(exibeForm:)];
        self.navigationItem.rightBarButtonItem = btn;
        self.navigationItem.leftBarButtonItem = self.editButtonItem;

    }
    return self;
}




-(void)exibeForm:(id)sender {

    FormularioContatoViewController* form = [[FormularioContatoViewController alloc] init];
    form.delegate = self;
    
    [self.navigationController pushViewController:form animated:YES];
    //[self presentViewController:form animated:YES completion:nil];
    
}

-(void)contatoAdicionado:(Contato*)contato {
    [self.contatos addObject:contato];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.contatos count];
}

-(UITableViewCell*) tableView:(UITableView*) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *pool = @"pool";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:pool];
    
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:pool];
    }
    
    Contato* contato = self.contatos[indexPath.row];
    cell.textLabel.text = contato.nome;
    cell.detailTextLabel.text = contato.email;
    
    return cell;
}

-(void) viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.contatos removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Contato* contato = self.contatos[indexPath.row];
    FormularioContatoViewController *form = [[FormularioContatoViewController alloc] initWithContato:contato];
    //form.contatos = self.contatos;
    
    [self.navigationController pushViewController:form animated:YES];
    
    NSLog(@"Contato selecionado: %@", contato.nome);
}

@end

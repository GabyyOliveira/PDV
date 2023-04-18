//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function cupom
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author fabio
@since 24/03/2023 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function cupom()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 647
    Local nJanLargur    := 1273 
    Local cJanTitulo    := 'PDialogMaker - Versao 1.02'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog 
    //Logo 
    Private oGetLogo 
    Private xGetLogo    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //InfoEmpre 
    Private oGetInfoEmpre 
    Private xGetInfoEmpre    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //InfoVenda 
    Private oGetInfoVenda 
    Private xGetInfoVenda    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //Ops1 
    Private oGetOps1 
    Private xGetOps1    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //QRCOD 
    Private oGetQRCOD 
    Private xGetQRCOD    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //CodBarra 
    Private oGetCodBarra 
    Private xGetCodBarra    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //Janela 
    Private oGetJanela 
    Private xGetJanela    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //Logo - usando a classe TGet
        nObjLinha := 15
        nObjColun := 235
        nObjLargu := 35
        nObjAltur := 35
        oGetLogo  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetLogo := u, xGetLogo)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetLogo:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetLogo:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetLogo:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetLogo:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetLogo:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetLogo:Picture    := '@!'                        //Mascara / Picture do campo

        //InfoEmpre - usando a classe TGet
        nObjLinha := 15
        nObjColun := 275
        nObjLargu := 125
        nObjAltur := 35
        oGetInfoEmpre  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetInfoEmpre := u, xGetInfoEmpre)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetInfoEmpre:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetInfoEmpre:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetInfoEmpre:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetInfoEmpre:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetInfoEmpre:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetInfoEmpre:Picture    := '@!'                        //Mascara / Picture do campo

        //InfoVenda - usando a classe TGet
        nObjLinha := 56
        nObjColun := 235
        nObjLargu := 165
        nObjAltur := 165
        oGetInfoVenda  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetInfoVenda := u, xGetInfoVenda)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetInfoVenda:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetInfoVenda:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetInfoVenda:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetInfoVenda:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetInfoVenda:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetInfoVenda:Picture    := '@!'                        //Mascara / Picture do campo

        //Ops1 - usando a classe TGet
        nObjLinha := 15
        nObjColun := 235
        nObjLargu := 165
        nObjAltur := 295
        oGetOps1  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetOps1 := u, xGetOps1)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetOps1:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetOps1:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetOps1:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetOps1:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetOps1:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetOps1:Picture    := '@!'                        //Mascara / Picture do campo

        //QRCOD - usando a classe TGet
        nObjLinha := 255
        nObjColun := 295
        nObjLargu := 50
        nObjAltur := 50
        oGetQRCOD  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetQRCOD := u, xGetQRCOD)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetQRCOD:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetQRCOD:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetQRCOD:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetQRCOD:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetQRCOD:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetQRCOD:Picture    := '@!'                        //Mascara / Picture do campo

        //CodBarra - usando a classe TGet
        nObjLinha := 226
        nObjColun := 272
        nObjLargu := 100
        nObjAltur := 22
        oGetCodBarra  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetCodBarra := u, xGetCodBarra)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetCodBarra:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetCodBarra:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetCodBarra:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetCodBarra:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetCodBarra:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetCodBarra:Picture    := '@!'                        //Mascara / Picture do campo

        //Janela - usando a classe TGet
        nObjLinha := 11
        nObjColun := 230
        nObjLargu := 175
        nObjAltur := 305
        oGetJanela  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetJanela := u, xGetJanela)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetJanela:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetJanela:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetJanela:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetJanela:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetJanela:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetJanela:Picture    := '@!'                        //Mascara / Picture do campo

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return

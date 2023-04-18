#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

//! CONSTANTES
#DEFINE FOTO 'C:\Users\gabyy\OneDrive\Documentos\Development\TOTVS\PDV\Img\'
#DEFINE CLR_BACK RGB(232,226,226)

User Function PDV()

	Private oDlg
	Private cImgInicial := "C:\TOTVS12\PROJETOS\PDV\Ini.png"

	//variaveis relacionadas ao produto
	Private cCode    := space(9)
	Private cDesc    := 'Descrição do Produto'
	Private cUni     := ''
	Private cCodeBar := ''
	Private cPreco   := ''
	Private nPreco   := 0
	Private cQtdEstoque := ''
	Private cQtd      := ''
	Private nQtd      := 1
	Private nSubTot   := 0
	Private cSubTot   := ''
	Private nDesconto := 0
	Private nTotal    := 0
	Private cTotal    := ''
	Private cVlrU     := ''
	Private aProdutos := {}
	Private oFotoProduto

	//variaveis relacionados ao cliente
	Private cCodCli := space(9)
	Private cNome := ''
	Private cCnpj := ''

	//finalização produto	
	Private cTotalFinal := 0
	Private nVlrDesconto := 0


	Private cCss :=;
		"QGroupBox {"+;
			"background-color: rgb(255,255,255); " +;
			"border-radius: 8px "+;
		"}"+;
		"QLabel {"+;
			"color: #B2B2B2;"+;
			"font: Arial;"+;
			"font-size: 18px;"+;
			"background: rgb(255,255,255);"+;
		"}"+;
		'QLineEdit {'+;
			'border-radius: 8px;'+;
			'font-size: 20px ;'+;
			'font-weight: bold;'+;
			'font: Arial ;'+; 
			'color: #B2B2B2'+;
	'}'

	Private cCssProduto :=;
		'QLabel {'+;
			'color: #B2B2B2;'+;
			'font-weight: bold;'+;
			'font-size: 25px;'+;
			'background: rgb(255,255,255);'+;
	'}'
	Private cCssTabela :=;
		'QLabel {'+;
		' color: #434242;'+;
		' font-size: 15px;'+;
		' background: rgb(255,255,255)'+;
	'}'

	Private cCssTotal :=;
		'QLabel {'+;
		'color: #B2B2B2;'+;
		'font-weight: bold;'+;
		'font-size: 16px;'+;
		' background: rgb(255,255,255)'+;
	'}'

	Private cExibeTotal := '<h4 style="color: #3E7C17"> TOTAL: R$ 0,00</h4>'
	Private cExibeSubTot := '<p>SubTotal: R$0,00</p>'
	Private cExibeDesconto := '<p>Desconto: R$0,00</p>'

	rpcsetenv('99','01')

	oDlg := MsDialog():New(0,0,720, 1274, 'PDV',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	//!foto
	oLogo := TBitmap():New(6,9, 217, 75,,(FOTO + 'ff.png') , .t., oDlg,,,.f.,.f.,,,.f.,,.t.,,.f.)

	
	//!PESQUISA DO PRODUTO
	oGpPesquisa   := TGroup():New(90,8,120,225,'',oDlg,,,.T.); oGpPesquisa:SetCss(cCss)
	oTBitmap1     := TBitmap():New(97.5,18.5, 15, 15,,(FOTO + 'pesq.png') , .t., oDlg,{|| U_searchProd()},,.f.,.f.,,,.f.,,.t.,,.f.)
	oGetCode      := TGet():New(95, 35.5, {|u| Iif(PCount() > 0 , cCode := u, cCode)}, oDlg, 100, 20, "@!",,,,, , ,.t.,,,,,,{ || U_searchProd()  },,,,,,,,.T.); oGetCode:SetCss(cCss); oGetCode:cPlaceHold := 'Pesquisar Produto'


	//!PRODUTO ID
	oGpProduto 	  := TGroup():New(130,8,356,225,'',oDlg,,,.T.); oGpProduto:SetCss(cCss)
	oCampo     	  := Tsay():New(140,92,{|| 'Produto'},oDlg,,,,,,.T.,,,70,20,,,,,,.t.) ; oCampo:SetCss(cCssProduto)	
	oFotoProduto  := TBitmap():New(167,65,252,192,,cImgInicial,.t., oDlg,,,.f.,.f.,,,.f.,,.t.,,.f.) 
	oSayDescricao := Tsay():New(260,15,{|| cDesc},oDlg,,,,,,.T.,,,202,30,,,,,,.t.) ; oSayDescricao:SetCss(cCssProduto)	; oSayDescricao:SetTextAlign(2,2)

	//unidade de medida do produto
	oCampo        := Tsay():New(290,15,{|| 'Unidade de Medida: '},oDlg,,,,,,.T.,,,100,20,,,,,,.t.) ; oCampo:SetCss(cCss)	
	oSayUnidade   := Tsay():New(290,200,{|| cUni },oDlg,,,,,,.T.,,,20,20,,,,,,.t.) ; oSayUnidade:SetCss(cCss)
	
	//codigo de barras do produto
	oCampo        := Tsay():New(306,15,{|| 'Código de Barra: '},oDlg,,,,,,.T.,,,80,20,,,,,,.t.) ; oCampo:SetCss(cCss)	
	oSayCodeBar   := Tsay():New(306,150,{|| cCodeBar  },oDlg,,,,,,.T.,,,70,20,,,,,,.t.) ; oSayCodeBar:SetCss(cCss)

	//quantidade em estoque
	oCampo        := Tsay():New(323,15,{|| 'Qtd. Estoque: '},oDlg,,,,,,.T.,,,100,20,,,,,,.t.) ; oCampo:SetCss(cCss)	
	oSayQtdEst    := Tsay():New(323,200,{|| cQtdEstoque },oDlg,,,,,,.T.,,,20,20,,,,,,.t.) ; oSayQtdEst:SetCss(cCss)

	//valor unitario
	oCampo        := Tsay():New(340,15,{|| 'Valor Unitário: '},oDlg,,,,,,.T.,,,80,10,,,,,,.t.) ; oCampo:SetCss(cCss)	
	oSayVlrUnit   := Tsay():New(338,165,{|| cPreco },oDlg,,,,,,.T.,,,60,15,,,,,,.t.) ; oSayVlrUnit:SetCss(cCssProduto)


	//!TABELA PRODUTOS
	oGpTabela 	  := TGroup():New(6,232,252,630,'',oDlg,,,.T.); oGpTabela:SetCss(cCss)
	oScroll       := TScrollArea():New(oDlg, 10,237,230,390)

	//Grid
	oInfoProd := TGrid():New(oDlg,12,236,387,900)
	oScroll:SetFrame(oInfoProd)
	
	oInfoProd:AddColumn(1, "Cod", 75,CONTROL_ALIGN_LEFT,.T.)
	oInfoProd:AddColumn(2, "Produto", 230, CONTROL_ALIGN_LEFT, .T.)
	oInfoProd:AddColumn(3, "Qtde", 50, 0, .t.)
	oInfoProd:AddColumn(4, "Valor Unit", 100, 0, .T.)
	oInfoProd:AddColumn(5, "SubTotal", 100, 0, .T.)
	oInfoProd:AddColumn(6, "Desconto", 99, 0, .T.)
	oInfoProd:AddColumn(7, "Total", 119, 0, .T.)
	oInfoProd:SetRowData(0, {|| {space(75), space(230), space(50), space(100), space(100), space(99), space(119)}})
	oInfoProd:lShowGrid := .f.
	oInfoProd:SetCss("QTableView {border: none; background: rgb(255,255,255); color: #B2B2B2; font-size: 15px; font-weight: bolder}")
	

	//!BOTÕES 
	//finaliza compra
	oBtnFinaliza  := TButton():New(257,231,"Finalizar",oDlg,{|| PagFinaliza()},75,32,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnFinaliza:SetCss("QPushButton {background-repeat: none; border: none; margin:3px; background-position: left; background-color: #A3CDA7; background-image: url(rpo:car.png); border-radius: 9px; padding-left: 10px; font-size: 18px; color: rgb(55, 146, 55); font: Arial; }")
	
	//aplica Desconto
	oBtnDesconto  := TButton():New(257,312,"Desconto",oDlg,{|| u_desconto()},75,32,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnDesconto:SetCss("QPushButton {background-repeat: none; border: none; margin:3px; background-position: left; background-color: rgb(255,255,255); background-image: url(rpo:porcent.png); border-radius: 9px; padding-left: 10px; font-size: 18px; color: #B2B2B2; font: Arial }")

	//Pesquisa produto
	oBtnPesquisa  := TButton():New(257,394,"Visualizar",oDlg,{|| U_Pesquisa()},75,32,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnPesquisa:SetCss("QPushButton {background-repeat: none; border: none; margin:3px; background-position: left; background-color: rgb(255,255,255); background-image: url(rpo:nn.png); border-radius: 9px; padding-left: 10px; font-size: 18px; color: #B2B2B2; font: Arial }")

	//Cancela item
	oBtnCancelItem := TButton():New(257,475,"Cancelar Item",oDlg,{|| U_Telacancel()},75,32,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnCancelItem:SetCss("QPushButton { border: none; margin:3px; background-color: rgb(255,255,255); border-radius: 9px;font-size: 18px; color: #B2B2B2; font: Arial }")

	//Cancela Pedido
	oBtnCancelar  := TButton():New(257,557,"Cancelar",oDlg,{||U_Recarrega()},75,32,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnCancelar:SetCss("QPushButton {background-repeat: none; border: none; margin:3px; background-position: left; background-color:   #ECB7B7; background-image: url(rpo:lixinho.png); border-radius: 9px; padding-left: 10px; font-size: 18px; color: #E21818; font: Arial }")


	//!CAMPO PARA APRESENTAR O NOME DO CLIENTE PESQUISADO
	oGpApresentaCli := TGroup():New(294,231,320,425,'',oDlg,,,.T.); oGpApresentaCli:SetCss(cCss)
	oTBitmap2       := TBitmap():New(300.5,241, 13, 13,,(FOTO + 'Vector.png') , .t., oDlg,,,.f.,.f.,,,.f.,,.t.,,.f.)
	oGetNomeCli     := TGet():New(297, 254, {|u| Iif(PCount() > 0 , cNome := u, cNome)}, oDlg, 150, 20, "@!",,,,, , ,.t.,,,,,,, .f.); oGetNomeCli:SetCss(cCss)
	

	//!CAMPO PARA PESQUISAR CLIENTE
	oGpPesquisaCli  := TGroup():New(330,231,356,425,'',oDlg,,,.T.); oGpPesquisaCli:SetCss(cCss)
	oTBitmap3       := TBitmap():New(336,241, 13, 13,,(FOTO + 'pesq.png') , .t., oDlg,{|| searchCli()},,.f.,.f.,,,.f.,,.t.,,.f.)
	oGetPesquisaCli := TGet():New(333, 254, {|u| Iif(PCount() > 0 , cCodCli := u, cCodCli)}, oDlg, 160, 20, "@!",,,,, , ,.t.,,,,,,, .f.); oGetPesquisaCli:SetCss(cCss)
	oGetPesquisaCli:cPlaceHold := 'Pesquisar Cliente'
	
	
	//!CAMPO PARA APRESENTAR O TOTAL
	oGpTotal     := TGroup():New(294,435,356,630,'',oDlg,,,.T.); oGpTotal:SetCss(cCss)
	oSubTotal    := Tsay():New(300,443,{|| cExibeSubTot},oDlg,,,,,,.T.,,,100,10,,,,,,.t.); oSubTotal:SetCss(cCssTotal)
	oDesconto    := Tsay():New(300,540,{|| cExibeDesconto},oDlg,,,,,,.T.,,,80,10,,,,,,.t.); oDesconto:SetCss(cCssTotal)
	oTotal       := Tsay():New(330,443,{|| cExibeTotal},oDlg,,,,,,.T.,,,180,20,,,,,,.t.); oTotal:SetTextAlign(2,2)
	oTotal:SetCss('QLabel {color: #3E7C17; font-weight: bold; font-size: 35px; background: transparent}')

	oDlg:Activate(,,,.T.,,,)
Return

static function searchCli()
	Local aArea := GetArea()
	Local cAlias := GetNextAlias()
	Local cQuery := ''

	cQuery := 'SELECT * FROM ' + RetSqlName('SA1') + ' SA1' + CRLF
	cQuery += "WHERE A1_COD = '" + cCodCli + "' AND D_E_L_E_T_ = ' ' "

	TCQUERY cQuery ALIAS &(cAlias) NEW

	while &(cAlias)->(!EOF())
		cNome := &(cAlias)->(A1_NOME)
		cCnpj := &(cAlias)->(A1_CGC)

		&(cAlias)->(DbSkip())
	enddo

	&(cAlias)->(DbCloseArea())
	RestArea(aArea)

return

Static Function PagFinaliza()

	if Empty(cNome)
		FwAlertInfo('Por gentileza Informe o Nome do Cliente', 'Cliente não Selecionado')
	else 
		U_Finaliza()
	endif 
return 

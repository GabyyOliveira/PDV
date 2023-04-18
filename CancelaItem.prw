#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

#DEFINE CLR_BACK rgb(232, 226, 226)

User Function Telacancel()
	
	Private oDlgCancel

    //variaveis de codigo do produto e quantidade
	Private cCodigo := space(9)
    Private xQtdRetirar := space(9)

    //variaveis de estilo 
	Private cCss := ''
	Private cCssLoja := ''
	Private cCssBtn := ''

	cCss :=;
		"QGroupBox {"+;
		    "background-color: rgb(255,255,255); " +;
		    "border-radius: 8px "+;
		"}"+;
		"QLabel {"+;
		    "color: #B2B2B2;"+;
		    "font: Arial;"+;
		    "font-size: 18px"+;
		"}"+;
		"QLineEdit {"+;
		    "border-radius: 8px;"+;
		    "font-size: 20px ; "+;
		    "font-weight: bold; "+;
		    "font: Arial ; "+;
		    "color: #B2B2B2"+;
		"}"+;
		"QPushButton {"+;
		    "background-repeat: none;"+;
		    "border: none;"+;
		    "margin:3px;"+;
		    "background-position: left;"+;
		    "background-color: rgb(255,255,255);"+;
		    "background-image: url(rpo:pesq.png);"+;
		    "border-radius: 8px;"+;
		    "padding-left: 10px;"+;
		    "font-size: 18px;"+;
		    "color: #B2B2B2;"+;
		    "font: Arial"+;
		"}"

    
	cCssLoja :=;
		"QPushButton {"+;
		    "background-image: url(rpo:chart.png);"+;
		    "background-repeat: none;"+;
		    "border: none;"+;
		    "padding-left: 10px;"+;
		    "background-position: left;"+;
		"}"
	cCssBtn :=;
		"QPushButton {"+;
			"background: rgb(255,255,255);"+;
			"color: #B2B2B2;"+;
			"font: bold ;"+;
			"border-radius: 8px;"+;
			"border: none;"+;
			"font-size: 18px;"+;
		"}"

	oDlgCancel := MsDialog():New(0,0,229,426, 'Cancelar Item',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	//!CAMPO CODIGO DO PRODUTO
	oGpCancelItem  := TGroup():New(10,13,35,200,'',oDlgCancel,,,.T.); oGpCancelItem:SetCss(cCss)
	oIconCancel    := TButton():New(12,14,"",oDlgCancel,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oIconCancel:SetCss(cCss)
	oGetCancelItem := TGet():New(11, 33.5, {|u| Iif(PCount() > 0 , cCodigo := u, cCodigo)}, oDlgCancel, 100, 20, "@!",,,,, , ,.t.); oGetCancelItem:SetCss(cCss)
	oGetCancelItem:cPlaceHold := 'Código do Produto'

	
	//!QUANTIDADE A RETIRAR
	oGpQuantidade  := TGroup():New(45,13,70,200,'',oDlgCancel,,,.T.); oGpQuantidade:SetCss(cCss)
	oIconQtd     := TButton():New(47,16,"",oDlgCancel,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oIconQtd:SetCss(cCssLoja)
	oGetQtd   := TGet():New(46, 33.5, {|u| Iif(PCount() > 0 , xQtdRetirar := u, xQtdRetirar)}, oDlgCancel, 100, 20, "@!",,,,, , ,.t.); oGetQtd:SetCss(cCss)
	oGetQtd:cPlaceHold := 'Quantidade'


	//!BOTÕES
	oBtnFechar := TButton():New(80,13,"Fechar",oDlgCancel,{|| oDlgCancel:End()},90,20,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnFechar:SetCss(cCssBtn)
	oBtnCancelItem  := TButton():New(80,110,"Cancelar Item",oDlgCancel,{|| U_CancelaItem()},90,20,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnCancelItem:SetCss(cCssBtn)


	oDlgCancel:Activate(,,,.T.,,,)
return



#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

#DEFINE CLR_BACK  rgb(232, 226, 226)
User Function Vendor()
	

	//Variaveis do Vendedor
	Local cCode := space(6)
	Private cLoja := space(3)
	Private cVendedor := ''
	Private oDlgLogin

	//Variaveis de estilo
	Private cCss :=;
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
	Private cCssLoja :=;
		"QPushButton {"+;
		"background-image: url(rpo:loja.png);"+;
		"background-repeat: none;"+;
		"border: none;"+;
		"padding-left: 10px;"+;
		"background-position: left;"+;
		"}"

	Private cCssBtn :=;
			"QPushButton {"+;
			"background: rgb(255,255,255); "+;
			"color: #B2B2B2;"+;
			"font: bold ;"+;
			"border-radius: 8px;"+;
			"border: none;"+;
			"font-size: 18px;"+;
			"}"

	PREPARE ENVIRONMENT EMPRESA '99' FILIAL '01' TABLES 'SA3' MODULO 'FIN'

	oDlgLogin := MsDialog():New(0,0,229,426, 'PDV',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	//!pesquisa vendedor
	oGpVendedor  := TGroup():New(10,13,35,200,'',oDlgLogin,,,.T.); oGpVendedor:SetCss(cCss)
	oPesquisa    := TButton():New(12,14,"",oDlgLogin,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oPesquisa:SetCss(cCss)
	oGetVendedor := TGet():New(11, 33.5, {|u| Iif(PCount() > 0 , cCode := u, cCode)}, oDlgLogin, 100, 20, "@!",,,,, , ,.t.); oGetVendedor:SetCss(cCss)
	oGetVendedor:cPlaceHold := 'Pesquisar Vendedor'
	

	//!Pesquisa a loja
	oGpLoja  := TGroup():New(45,13,70,200,'',oDlgLogin,,,.T.); oGpLoja:SetCss(cCss)
	oLoja := TButton():New(47,16,"",oDlgLogin,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oLoja:SetCss(cCssLoja)
	oGetLoja := TGet():New(46, 33.5, {|u| Iif(PCount() > 0 , cLoja := u, cLoja)}, oDlgLogin, 100, 20, "@!",,,,, , ,.t.); oGetLoja:SetCss(cCss)
	oGetLoja:cPlaceHold := 'Digite a Loja...'

	//!BOTÕES
	oBtnSair  := TButton():New(80,13,"Sair",oDlgLogin,{|| oDlgLogin:End()},90,20,,,.f.,.t.,.f.,,.f.,,,.f.); oBtnSair:SetCss(cCssBtn)
	oBtnEntrar  := TButton():New(80,110,"Entrar",oDlgLogin,{|| U_Entrar(cCode)},90,20,,,.f.,.t.,.f.,,.f.,,,.f.); oBtnEntrar:SetCss(cCssBtn)

	oDlgLogin:Activate(,,,.T.,,,)
return



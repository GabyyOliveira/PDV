#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

//!CONSTANTES
#DEFINE CLR_BACK rgb(232, 226, 226)

User Function desconto()
	Private oDlgDesconto

	Private cVlrDesconto := ''
	Private nPorcent := space(9)
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
		"background-image: url(rpo:porcent.png);"+;
		"border-radius: 8px;"+;
		"padding-left: 10px;"+;
		"font-size: 18px;"+;
		"color: #B2B2B2;"+;
		"font: Arial"+;
		"}"
	Private cCssIcon :=;
		"QPushButton {"+;
		"background-image: url(rpo:ficha.png);"+;
		"background-repeat: none;"+;
		"border: none;"+;
		"padding-left: 10px;"+;
		"background-position: left;"+;
		"}"

	oDlgDesconto := MsDialog():New(0,0,229,426, 'Aplicar Desconto',,,,,CLR_BLACK,CLR_BACK,,,.T.) 

	//!INFORMA A PORCENTAGEM DO DESCONTO
	oGpDesconto  := TGroup():New(10,13,35,200,'',oDlgDesconto,,,.T.); oGpDesconto:SetCss(cCss)
	oDesconto    := TButton():New(12,14,"",oDlgDesconto,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oDesconto:SetCss(cCss)
	oGetDesconto := TGet():New(11, 33.5, {|u| Iif(PCount() > 0 , nPorcent := u, nPorcent)}, oDlgDesconto, 100, 20, "@!",,,,, , ,.t.,,,,,,{ || U_CalcDesconto() }); oGetDesconto:SetCss(cCss)
	oGetDesconto:cPlaceHold := 'Desconto'


	//!APRESENTA O VALOR DO DESCONTO
	oGpValorDesconto  := TGroup():New(45,13,70,200,'',oDlgDesconto,,,.T.); oGpValorDesconto:SetCss(cCss)
	oIconDesconto     := TButton():New(47,16,"",oDlgDesconto,{|| alert('botao')},27,20,,,.f.,.t.,.f.,,.f.,,,.f.); oIconDesconto:SetCss(cCssIcon)
	oGetVlrDesconto   := TGet():New(46, 33.5, {|u| Iif(PCount() > 0 , cVlrDesconto := u, cVlrDesconto)}, oDlgDesconto, 100, 20, "@!",,,,, , ,.t.); oGetVlrDesconto:SetCss(cCss)
	oGetVlrDesconto:cPlaceHold := 'Valor do Desconto'

	//!BOTÕES
	oBtnCancelar  := TButton():New(80,13,"Cancelar",oDlgDesconto,{|| oDlgDesconto:End()},90,20,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnCancelar:SetCss("QPushButton {background: rgb(255,255,255); color: #B2B2B2;font: bold ;border-radius: 8px; border: none;font-size: 18px;}")
	oBtnAplicar   := TButton():New(80,110,"Aplicar",oDlgDesconto,{|| U_AplicaDesconto()},90,20,,,.f.,.t.,.f.,,.f.,,,.f.)
	oBtnAplicar:SetCss("QPushButton {background: #A3CDA7; color: rgb(55, 146, 55);font: bold ;border-radius: 8px; border: none;font-size: 18px;}")


	oDlgDesconto:Activate(,,,.T.,,,)

return

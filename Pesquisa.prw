#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Pesquisa
    pesquisa produto
    @type  Function
    @author user
    @since 30/03/2023
/*/

//! CONSTANTES
#DEFINE CLR_BACK RGB(216,216,216)

User Function Pesquisa()

	Private oDlgPesq
	Private cCss :=;
		"QGroupBox {"+;
		"background-color: rgb(255,255,255); " +;
		"border-radius: 8px "+;
		"}"+;
		"QLabel {"+;
		    "color: #B2B2B2;"+;
		    "font: Arial;"+;
		    "font-size: 18px;"+;
			"background: transparent"+;
		"}"
	Private cCssProduto :=;
		'QLabel {'+;
			'color: #B2B2B2;'+;
			'font-weight: bold;'+;
			'font-size: 25px;'+;
			'background: rgb(255,255,255);'+;
	'}'
	Private cImgInicial := "C:\TOTVS12\PROJETOS\PDV\Ini.png"

  Private aCursor := oInfoProd:GetCursorPos()


	oDlgPesq   := MsDialog():New(0,0,326, 817, 'Pesquisa Produto',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	oProd     := Tsay():New(16,14,{|| 'Produto'},oDlgPesq,,,,,,.T.,,,160,20,,,,,,.t.) ; oProd:SetCss(cCssProduto) ; oProd:SetTextAlign(2,2)
	oPhoto     := TBitmap():New(40,40,300,300,,(aProdutos[aCursor[1]][8]),.t., oDlgPesq,,,.f.,.f.,,,.f.,,.t.,,.f.)
	oGpFoto    := TGroup():New(8,11,156,175,'',oDlgPesq,,,.T.); oGpFoto:SetCss(cCss)
	 

	oGpInfos   := TGroup():New(8,183,130,400,'',oDlgPesq,,,.T.); oGpInfos:SetCss(cCss)
	oDescricao := Tsay():New(10,186,{|| aProdutos[aCursor[1]][2]},oDlgPesq,,,,,,.T.,,,210,20,,,,,,.t.) ; oDescricao:SetCss(cCss); oDescricao:SetTextAlign(0,2)
	oUnMedida  := Tsay():New(40,186,{|| PADR('Unidade de Medida: ', 63) + aProdutos[aCursor[1]][10]},oDlgPesq,,,,,,.T.,,,210,20,,,,,,.t.) ; oUnMedida:SetCss(cCss); oUnMedida:SetTextAlign(0,2)
	oUnMedida  := Tsay():New(60,186,{|| PADR('Código de Barra: ', 44) + aProdutos[aCursor[1]][9]},oDlgPesq,,,,,,.T.,,,210,20,,,,,,.t.) ; oUnMedida:SetCss(cCss); oUnMedida:SetTextAlign(0,2)
	oUnMedida  := Tsay():New(80,186,{|| PADR('Qtd. Estoque: ', 70) + cValToChAr(aProdutos[aCursor[1]][3])},oDlgPesq,,,,,,.T.,,,210,20,,,,,,.t.) ; oUnMedida:SetCss(cCss); oUnMedida:SetTextAlign(0,2)
	oUnMedida  := Tsay():New(100,186,{|| PADR('Valor Unitário: ', 60) + aProdutos[aCursor[1]][11]},oDlgPesq,,,,,,.T.,,,210,20,,,,,,.t.) ; oUnMedida:SetCss(cCss); oUnMedida:SetTextAlign(0,2)

	oBtnFecha  := TButton():New(137,240,"Fechar",oDlgPesq,{|| oDlgPesq:End()},105,20,,,.f.,.t.,.f.,,.f.,,,.f.)

	oDlgPesq:Activate(,,,.T.,,,)
Return

#INCLUDE 'TOTVS.CH'

/*/{Protheus.doc} User Function Cupom
    Tela Cupom Fiscal
    @type  Function
    @author Gabriela Oliveira
    @since 10/04/2023
/*/
#DEFINE CLR_BACK RGB(232,226,226)

User Function Cupom()
	Local cCss :=;
		"QGroupBox {background-color: rgb(255,255,255); border-radius: 8px }"+;
		'QLineEdit {color: #B2B2B2;font: Arial;font-size: 16px; border:none ; border-radius: 5px}'+;
		"QPushButton {font: bold ;border-radius: 8px; border: none;font-size: 18px;"
    Local cCssSay :=;
		"QLabel {color: #626262;Font: Roboto; font-weight: bold ; background: rgb(255,255,255);"


	Private oDlgCupom
	Private cCupom := CupomTable()



	oDlgCupom := MsDialog():New(0,0,720, 1274, 'Cupom Fiscal',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	oGpJanela := TGroup():New(20,210, 340, 410, '', oDlgCupom,,,.t.); oGpJanela:SetCss(cCss)
    oScroll   := TScrollArea():New(oDlgCupom, 35,215,300,190)

    oSayCupom := TSay():New(0,0, {||  cCupom }, oDlgCupom,,,,,,.T.,,,190,(325+(len(aProdutos) * 30)),,,,,,.t.); oSayCupom:SetCss(cCssSay)
    oScroll:SetFrame(oSayCupom)
    

	oDlgCupom:Activate(,,,.T.,,,)
Return

Static Function CupomTable()
	Local cLine := LoadLine()
	Local cCupom := ''+;
		'<table style="background-color: rgb(255,255,255)"><tr>'+;
		'<td width="80" colspan="2" style="text-align: center;"><img style="width: 50px; height: 50px" src="C:\Users\gabyy\OneDrive\Documentos\Development\TOTVS\PDV\Img\logo_camel_case.png"></td>'+;
		'<td width="80" colspan="5">Camel Case LTDA<br>Rua da Fortuna 289<br>JD Aricanduva São Paulo</td>'+;
		' </tr>'+;
		'<tr>'+;
		'<td height="10" colspan="7"></td>'+;
		' </tr>'+;
		'<tr>'+;
		' <td colspan="3">CNPJ: 43.324.756/0002-65</td>  '+;
		'<td colspan="2"></td>'+;
		' <td colspan="2" style="text-align: right;">IE: 388.108.598.269</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7" style="text-align: center;"><b>Extrato Nº 09<br>CUPOM FISCAL ELETRONICO-SAT</b></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7" style="text-align: left;">Nome do Consumidor: '+cNome+'<br>CPF/CNPJ do consumidor: '+cCnpj+'</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td> COD |</td>'+;
		'<td> DESC |</td>'+;
		'<td> QTD |</td>'+;
		'<td> UN |</td>'+;
		'<td>VL UNIT R$ |</td>'+;
		'<td> ALIQ |</td>'+;
		'<td> VL ITEM R$ |</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		cLine +;
		'<tr>'+;
		'<td height="30" colspan="7"></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="2">SubTotal</td>'+;
		'<td colspan="4"></td>'+;
		'<td style="text-align: Right;">'+STRTRAN(STR(nSubTot,7,2),".",",")+'</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="2"><b>Desconto</b></td>  '+;
		'<td colspan="4"></td>'+;
		'<td style="text-align: Right;"><b>'+STRTRAN(STR(nVlrDesconto,7,2),".",",")+'</b></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="2"><b>TOTAL R$</b></td>    '+;
		'<td colspan="4"></td>'+;
		'<td style="text-align: Right;"><b>'+STRTRAN(STR(cTotalFinal,7,2), ".", ",")+'</b></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td height="30" colspan="7"></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="2">Dinheiro R$</td>'+;
		'<td colspan="4"></td>'+;
		'<td style="text-align: Right;">'+STRTRAN(STR(nVlrDinheiro,7,2),".",",")+'</td>'+;
		'</tr>'+;
		' <tr>'+;
		'<td colspan="2"><b>Troco R$</b></td>  '  +;
		'<td colspan="4"></td>'+;
		'<td style="text-align: Right;"><b>'+cVlrTroco+'</b></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td height="30" colspan="7"></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7" style="text-align: center;"><b>SAT Nº 000.000.027</b><br>03/03/2023 - 14:57</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td colspan="7">---------------------------------------------------------------------------------------</td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td height="30" colspan="7"></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td style="text-align: center;" colspan="7"><img src="C:\Users\gabyy\OneDrive\Documentos\Development\TOTVS\PDV\Img\Codbar.png"></td>'+;
		'</tr>'+;
		'<tr>'+;
		'<td height="30" colspan="7"></td>'+;
		'</tr>'+;
		' <tr>'+;
		'<td style="text-align: center;" colspan="7"><img src="C:\Users\gabyy\OneDrive\Documentos\Development\TOTVS\PDV\Img\qrCode.png"></td>'+;
		'</tr>'+;
		'</table>'
return cCupom

Static Function LoadLine()
	Local cLine := ''
	Local nI 

	cVlrDesconto := STRTRAN(STR(nVlrDesconto,7,2),".",",")

	for nI := 1 to len(aProdutos)

		cLine += '<tr>'+;
		'<td width="50" style="text-align: left;" colspan="6">' + aProdutos[nI][1] + ' - ' + aProdutos[nI][2] + ' - ' + aProdutos[nI][10] + ' X ' + Alltrim(STRTRAN(str(aProdutos[nI][4]), ".", ",")) +  ' - ' +  cVlrDesconto + '</td>'+;
		'<td style="text-align: Right;">'+ Alltrim(STRTRAN(str(aProdutos[nI][5]), ".", ","))+ '</td>'+;
		'</tr>'
	next 
return cLine

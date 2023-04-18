#INCLUDE 'TOTVS.CH'

//! CONSTANTES
#DEFINE CLR_BACK RGB(232,226,226)
#DEFINE VLR_A_PAGAR 'Valor a pagar'
#DEFINE TROCO 'Troco: '
#DEFINE FALTANTE 'Falta pagar: '
#DEFINE TOTAL_PAGO 'Valor Pago: '

User Function Finaliza()
	//! Variaveis de estilo
	Local cCssSay :=;
		"QLabel {color: #626262;Font: Roboto; font-weight: bold ; background: transparent;"

	Local cCss :=;
		"QGroupBox {background-color: #F0F0F0; border-radius: 8px }"+;
		'QLineEdit {color: #B2B2B2;font: Arial;font-size: 16px; border:none ; border-radius: 5px}'+;
		"QPushButton {font: bold ;border-radius: 8px; border: none;font-size: 18px;"

	Private nFaltante := cTotalFinal
	Private oDlgFinaliza
	Private cExibeSubTotal
	Private cVlrTroco := 'R$0,00'
	Private cVlrPago := 'R$0,00'
	Private cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))

	Private nVlrCredito  := 0
	Private nVlrDebito   := 0
	Private nVlrDinheiro := 0
	Private nVlrPix      := 0


	Private cMostraTotal := '<h4> R$' + STRTRAN(STR(cTotalFinal,7,2), ".", ",") + '</h4>'
	cExibeSubTot := '<p>Subtotal: R$' + STRTRAN(STR(nSubTot,7,2),".",",") + '</p>'
	cExibeDesconto := '<p>Desconto: R$' + STRTRAN(STR(nVlrDesconto,7,2),".",",") + '</p>'



	oDlgFinaliza := MsDialog():New(0,0,720, 1274, 'Finaliza Compra',,,,,CLR_BLACK,CLR_BACK,,,.T.)

	oGpJanela := TGroup():New(20,210, 340, 410, '', oDlgFinaliza,,,.t.); oGpJanela:SetCss(cCss)
	oSayTxt := TSay():New(40,215, {|| VLR_A_PAGAR }, oDlgFinaliza,,,,,,.T.,,,190,10,,,,,,.t.); oSaytxt:SetTextAlign(2,2); oSayTxt:SetCss(cCssSay + 'font-size: 16px}')

	oSayValorTotal := TSay():New(50,215, {||  cMostraTotal}, oDlgFinaliza,,,,,,.T.,,,190,32,,,,,,.t.); oSayValorTotal:SetTextAlign(2,2)
	oSayValorTotal:SetCss(cCssSay + 'Font-size: 48px}')

	oSaySubTotal := TSay():New(85,225, {|| cExibeSubTot }, oDlgFinaliza,,,,,,.T.,,,170,10,,,,,,.t.); oSaySubTotal:SetTextAlign(0,2)
	oSaySubTotal:SetCss( cCssSay + 'font-size: 14px}')

	oSayDesconto := TSay():New(96,225, {||  cExibeDesconto}, oDlgFinaliza,,,,,,.T.,,,170,10,,,,,,.t.); oSayDesconto:SetTextAlign(0,2)
	oSayDesconto:SetCss( cCssSay + 'font-size: 14px}')

	//! Opções de pagamento
	//credito
	oSayCredito := TSay():New(130,225, {|| 'Credito: '}, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.);  oSayCredito:SetTextAlign(0,2);  oSayCredito:SetCss( cCssSay + 'font-size: 20px}')
	oGetCredito := TGet():New(132,275, {|u| Iif(PCount() > 0 , nVlrCredito := u, nVlrCredito)}, oDlgFinaliza,120, 15, "@E R$ 999,999.99",,,,, , ,.t.,,,,,,{ ||  PagCred()  },,,,,,,,.T.); oGetCredito:SetCss(cCss)

	//debito
	oSayDebito  := TSay():New(160,225, {|| 'Débito: '}, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayDebito:SetTextAlign(0,2); oSayDebito:SetCss(cCssSay + 'font-size: 20px}')
	oGetDebito  := TGet():New(162,275, {|u| Iif(PCount() > 0 , nVlrDebito := u, nVlrDebito)}, oDlgFinaliza,120, 15, "@E R$ 999,999.99",,,,, , ,.t.,,,,,,{ || PagDeb()  },,,,,,,,.T.); oGetDebito:SetCss(cCss)

	//dinheiro
	oSayDinheiro := TSay():New(190,225, {|| 'Dinheiro: '}, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayDinheiro:SetTextAlign(0,2); oSayDinheiro:SetCss(cCssSay + 'font-size: 20px}')
	oGetDinheiro := TGet():New(192,275, {|u| Iif(PCount() > 0 , nVlrDinheiro := u, nVlrDinheiro)}, oDlgFinaliza,120, 15, "@E R$ 999,999.99",,,,, , ,.t.,,,,,,{ || PagDin() },,,,,,,,.T.); oGetDinheiro:SetCss(cCss)

	//pix
	oSayPix := TSay():New(220,225, {|| 'Pix: '}, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.);  oSayPix:SetTextAlign(0,2);  oSayPix:SetCss(cCssSay + 'font-size: 20px}')
	oGetPix := TGet():New(222,275, {|u| Iif(PCount() > 0 ,  nVlrPix := u,  nVlrPix)}, oDlgFinaliza,120, 15, "@E R$ 999,999.99",,,,, , ,.t.,,,,,,{ ||  PagPix()  },,,,,,,,.T.); oGetPix:SetCss(cCss)

	//! Exibe Valores
	oSayTroco    := TSay():New(245,225, {||   TROCO   }, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayTroco:SetTextAlign(0,2);    oSayTroco:SetCss(cCssSay + 'font-size: 16px}')
	oSayVlrTroco := TSay():New(245,225, {|| cVlrTroco }, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayVlrTroco:SetTextAlign(1,2); oSayVlrTroco:SetCss(cCssSay + 'font-size: 17px}')

	oSayFaltante := TSay():New(265,225, {|| FALTANTE  }, oDlgFinaliza,,,,,,.T.,,,170,10,,,,,,.t.); oSayFaltante:SetTextAlign(0,2); oSayFaltante:SetCss(cCssSay + 'font-size: 16px ; color: #CD0000}')
	oSayVlrF     := TSay():New(260,225, {|| cVlrFalta }, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayVlrF:SetTextAlign(1,2);     oSayVlrF:SetCss(cCssSay + 'font-size: 17px ; color: #CD0000}')

	oSayPago     := TSay():New(277,225, {||TOTAL_PAGO }, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayPago:SetTextAlign(0,2);     oSayPago:SetCss( cCssSay + 'font-size: 20px ; color: #438B4A}')
	oSayVlrPago  := TSay():New(276,225, {|| cVlrPago }, oDlgFinaliza,,,,,,.T.,,,170,20,,,,,,.t.); oSayVlrPago:SetTextAlign(1,2);  oSayVlrPago:SetCss(cCssSay + 'font-size: 25px ; color: #438B4A}')

	//! BOTÕES
	oBtnCancel   := TButton():New(310,237,"Cancelar",oDlgFinaliza,{|| oDlgFinaliza:End()},70,20,,,.f.,.t.,.f.,,.f.,,,.f.);  oBtnCancel:SetCss(cCss + 'background: #ECB7B7; color: #CD0000}')
	oBtnFinaliza := TButton():New(310,315,"Finalizar",oDlgFinaliza,{||Confirma() },70,20,,,.f.,.t.,.f.,,.f.,,,.f.); oBtnFinaliza:SetCss(cCss + 'background: #A3CDA7; color: #438B4A}')

	oDlgFinaliza:Activate(,,,.T.,,,)
return

Static Function PagDin()
	Local nVlrPago  := 0
	Local nTroco := 0

	nFaltante :=  cTotalFinal - (nVlrCredito + nVlrDebito  + nVlrPix)
	nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix

	if nVlrPago > cTotalFinal
		nTroco := nVlrDinheiro - nFaltante
		nFaltante := 0
	else
		nFaltante := cTotalFinal - nVlrPago
	endif

	cVlrPago := 'R$' + Alltrim(STRTRAN(STR(nVlrPago,7,2), ".", ","))
	cVlrTroco := 'R$' + Alltrim(STRTRAN(STR(nTroco,7,2), ".", ","))
	cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))
return

Static Function PagCred()
	Local nVlrPago  := 0

	nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix

	if nVlrCredito > 0

		if nVlrCredito > nFaltante
			FwAlertError('Não é possivel voltar troco com o pagamento em crédito', 'Alerta')
			nVlrCredito := 0
			nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix
			nFaltante := cTotalFinal - nVlrPago
		else
			nFaltante := cTotalFinal - nVlrPago
		endif
	else
		nVlrCredito := 0
		nFaltante := cTotalFinal - nVlrPago
	endif

	cVlrPago := 'R$' + Alltrim(STRTRAN(STR(nVlrPago,7,2), ".", ","))
	cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))
return

Static Function PagDeb()
	Local nVlrPago  := 0

	cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))

	nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix

	if nVlrDebito > 0

		if nVlrDebito > nFaltante

			FwAlertError('Não é possivel voltar troco com o pagamento em Debito', 'Alerta')
			nVlrDebito := 0
			nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix
			nFaltante := cTotalFinal - nVlrPago
		else
			nFaltante := cTotalFinal - nVlrPago
		endif
	else
		nVlrDebito := 0
		nFaltante := cTotalFinal - nVlrPago
	endif

	cVlrPago := 'R$' + Alltrim(STRTRAN(STR(nVlrPago,7,2), ".", ","))
	cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))
return

Static Function PagPix()
	Local nVlrPago  := 0

	nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix

	if nVlrPix > 0

		if nVlrPix > nFaltante
			FwAlertError('Não é possivel voltar troco com o pagamento em Pix', "Alerta")
			nVlrPix := 0
			nVlrPago  := nVlrCredito + nVlrDebito + nVlrDinheiro + nVlrPix
			nFaltante := cTotalFinal - nVlrPago
		else
			nFaltante := cTotalFinal - nVlrPago
		endif
	else
		nVlrPix := 0
		nFaltante := cTotalFinal - nVlrPago
	endif

	cVlrPago := 'R$' + Alltrim(STRTRAN(STR(nVlrPago,7,2), ".", ","))
	cVlrFalta := 'R$' + Alltrim(STRTRAN(STR(nFaltante,7,2), ".", ","))
return

Static Function Confirma()
	Local lRet := .f.


	if MsgYesNo('Deseja Finalizar Compra?', 'Finalizar')

		if nFaltante > 0
			FwAlertError('Ainda há valores a serem pagos', 'Saldo')
		else

			FwAlertSuccess('Compra Finalizada, Obrigada pela preferencia!', 'Pagamento Confirmado')

			lRet := MsgYesNo('Deseja Imprimir o Cupom Fiscal?', 'Imprimir Cupom Fiscal')

			if lRet
				if MsgYesNo('Adicionar CPF na nota?', 'Cpf na Nota?')
					U_Cupom()
				else
					cCnpj := 'Cpf não adicionado'
					U_Cupom()
				endif
			else
				oDlgFinaliza:End()
				U_Recarrega()
			endif
		endif
	endif

return

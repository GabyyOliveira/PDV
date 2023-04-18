#INCLUDE 'TOTVS.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'

User Function searchProd()

	Local aArea := GetArea()
	Local cAlias := GetNextAlias()
	Local cQuery := ''
	Local cNewImg := ''
	Local nPos := aScan(aProdutos, {|x| AllTrim(x[1]) == Alltrim(cCode) })


	cQuery := 'SELECT * FROM ' + RetSqlName('SB1') + ' SB1' + CRLF
	cQuery += 'INNER JOIN ' + RetSqlName('SB2') + ' SB2 ON B1_COD = B2_COD' + CRLF
	cQuery += 'LEFT JOIN ' + RetSqlName('SB5') + ' SB5 ON B1_COD = B5_COD' + CRLF
	cQuery += "WHERE B1_COD = '" + cCode + "' AND SB1.D_E_L_E_T_ = ' ' AND B2_LOCAL = '01' "

	TCQUERY cQuery ALIAS &(cAlias) NEW

	while &(cAlias)->(!EOF())
		cDesc := Alltrim(&(cAlias)->(B1_DESC))
		cUni := &(cAlias)->(B1_UM)
		cCodeBar := &(cAlias)->(B1_CODBAR)
		cQtdEstoque := Alltrim(str(&(cAlias)->(B2_QATU)))
		nPreco := &(cAlias)->(B1_PRV1)
		cPreco := 'R$' + Alltrim(str(&(cAlias)->(B1_PRV1),7,2))
		cNewImg := Alltrim(&(cAlias)->(B5_ECIMGFI))

		&(cAlias)->(DbSkip())
	enddo

	if nPos > 0
		nQtd := aProdutos[nPos][3]
		nQtd++
		nSubTot := nPreco * nQtd
		aProdutos[nPos][3] := nQtd
		aProdutos[nPos][5] := nSubTot
		aProdutos[nPos][7] := nSubTot - nDesconto
	else
		nQtd := 1
		nSubTot := nPreco * nQtd
		nTotal := nSubTot - nDesconto
		aAdd(aProdutos,{cCode,cDesc,nQtd,nPreco,nSubTot,nDesconto,nTotal, cNewImg, Alltrim(cCodeBar), AllTrim(cUni), cPreco})
	endif

	nVlrDesconto := 0
	cCode := ''
	oFotoProduto:Load(,cNewImg)
	U_LoadList()


	&(cAlias)->(DbCloseArea())
	RestArea(aArea)
return

User function LoadList()
	Local nI

	//Zerando as variaveis

	cTotalFinal  := 0
	nSubTot      := 0

	//Limpando a Grid
	oInfoProd:ClearRows()
	oInfoProd:SetRowData(1, {|| {space(75), space(230), space(50), space(100), space(100), space(100), space(125)}})

	for nI := 1 to len(aProdutos)
		cCode := aProdutos[nI][1]
		cDesc := aProdutos[nI][2]
		cQtd  := cValToChar(aProdutos[nI][3])
		cVlrU := Alltrim(STRTRAN(str(aProdutos[nI][4]), ".", ","))
		cSubTot := Alltrim(STRTRAN(str(aProdutos[nI][5]), ".", ","))
		cTotal := Alltrim(STRTRAN(str(aProdutos[nI][7]), ".", ","))

		oInfoProd:SetRowData(nI, {|| {cCode, cDesc, cQtd, 'R$' + cVlrU, 'R$' + cSubTot, 'R$ 0,00' , 'R$' + cTotal}})
		oInfoProd:SetRowColor(nI, rgb(255,255,255), RGB(136,136,136))

		nSubTot += aProdutos[nI][5]

	next


	cTotalFinal := nSubTot - nVlrDesconto

	cExibeTotal := '<h4 style="color: #3E7C17"> TOTAL: R$' + STRTRAN(STR(cTotalFinal,7,2), ".", ",") + '</h4>'
	cExibeSubTot := '<p style="#B2B2B2">Subtotal: R$' + STRTRAN(STR(nSubTot,7,2),".",",") + '</p>'
	cExibeDesconto := '<p style="#B2B2B2">Desconto: R$' + STRTRAN(STR(nVlrDesconto,7,2),".",",") + '</p>'


return

User Function CancelaItem()
	Local nPos := aScan(aProdutos, {|x| AllTrim(x[1]) == Alltrim(cCodigo) })
	Local nQtdAtual := aProdutos[nPos][3]
	Local nNewQtd := 0
	Local nPreco := aProdutos[nPos][4]
	Local nNewSubTot := 0
	Local nDesconto := aProdutos[nPos][6]
	Local nTotal := aProdutos[nPos][7]


	if nPos > 0 .and. nQtdAtual >= 1

		If val(xQtdRetirar) < nQtdAtual
			// Atualiza quantidade
			nNewQtd := (nQtdAtual - val(xQtdRetirar))
			aProdutos[nPos][3] := nNewQtd

			//Atualiza subTotal
			nNewSubTot := nPreco * nNewQtd
			aProdutos[nPos][5] := nNewSubTot

			//Atualiza total
			nTotal := nNewSubTot - nDesconto
			aProdutos[nPos][7] := nTotal

			oDlgCancel:End()

		elseif val(xQtdRetirar) == nQtdAtual

			Adel(aProdutos, nPos)
			ASize(aProdutos, (len(aProdutos)-1))
			oDlgCancel:End()
		else
			FwAlertError('Quantidade a retirar é maior que a que esta no carrinho','Atenção')
		endif
	else
		FwAlertInfo('Não há produtos no carrinho com este codigo')
	endif

	nVlrDesconto := 0
	U_LoadList()
return

User Function CalcDesconto()

	nVlrDesconto := nSubTot * (val(nPorcent) / 100)
	cVlrDesconto := STRTRAN(STR(nVlrDesconto,7,2),".",",")
Return

User Function AplicaDesconto()
	U_LoadList()

	oDlgDesconto:End()
Return

User Function Recarrega()
	Local lRet := .f.

	lRet := MsgYesNo('Deseja realmente Cancelar a Compra?','Cancelar Compra')

	if lRet

		//variaveis do Produto
		aProdutos := {}
		cCode := space(9)
		cDesc := 'Descrição do Produto'
		cUni := ''
		cCodeBar := ''
		cQtdEstoque :=''
		nPreco := ''
		cPreco := ''
		cNewImg := ''

		//variaveis do cliente
		cNome := ''
		cCodCli := space(9)

		//variaveis dos valores finais
		cExibeTotal := '<h4 style="color: #3E7C17"> TOTAL: R$ 0,00</h4>'
		cExibeSubTot := '<p>SubTotal: R$0,00</p>'
		cExibeDesconto := '<p>Desconto: R$0,00</p>'


		oFotoProduto:Load(,cImgInicial)
		oInfoProd:ClearRows()
	endif
return

User Function Entrar(cCode)
	Local lLibera := .f.

	DbSelectArea('SA3')
	DbSetOrder(1)

	oDlgLogin:End()

	if DbSeek(xFilial('SA3') + cCode)
		cVendedor := SA3->A3_COD
		lLibera := .t.
	endif

	DbCloseArea()

	if lLibera
		U_PDV()
	else
		FwAlertError("Vendedor não encontrado!!",'Acesso negado')
	endif
return

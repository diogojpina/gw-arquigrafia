/////////////// Manipulação de listagens //////////////////////

// Objetos
function Coluna(titulo, alinhamento, ordenacao, icone) {
	this.titulo = titulo;
	if (alinhamento == null) {
		this.alinhamento = "left";
	} else {
		this.alinhamento = alinhamento;
	}
	if (ordenacao == null) {
		this.ordenacao = true;
	} else {
		this.ordenacao = ordenacao;
	}
	this.icone = icone;
}

function Celula(exibicao, valorEntrada) {
	this.exibicao = exibicao;
	this.valor = null;

	if (valorEntrada == null) {
		this.valor = exibicao;
	} else {
		this.valor = valorEntrada;
	}
}

// Variáveis intermediárias para se comunicar com a função de comparação.
var _tempColunaAOrdenar;
var _tempOrdem; // Ordem é 1 para crescente e -1 para decrescente

// Funções
function Tabela (nomeVariavel)  {
	this.vetorColunas = new Array();
	this.vetorLinhas = new Array();
	this.linha = new Array();
	this.colunaAOrdenar;
	this.ordem;
	this.nomeVariavel = nomeVariavel;

	this.addColuna = function(titulo, alinhamento, ordenacao, icone) {
		if (icone == null) icone = "";
		col = new Coluna(titulo, alinhamento, ordenacao, icone);
		this.vetorColunas[this.vetorColunas.length] = col;
	};

	this.addCelula = function(exibicao, valor) {
		celula = new Celula (exibicao, valor);
		this.linha[this.linha.length] = celula;
		if (this.linha.length == this.vetorColunas.length) {
			this.vetorLinhas[this.vetorLinhas.length] = this.linha;
			this.linha = new Array();
		}
	};

	this.reOrdenarTabela = function(coluna) {
		if (this.colunaAOrdenar == coluna) {
			_tempOrdem = -_tempOrdem; // Ordena inverso ao clicar de novo
		} else {
			_tempOrdem = 1;
		}
		this.colunaAOrdenar = coluna;
		_tempColunaAOrdenar = coluna;
		this.vetorLinhas.sort(this.comparaLinhas);
		eval("tabelaListagem" + this.nomeVariavel + ".innerHTML = this.montaListagem()");
	};

	this.comparaLinhas = function(a, b) {
		if (!isNaN(a[_tempColunaAOrdenar].valor) && !isNaN(a[_tempColunaAOrdenar].valor)) {
			// É um número
			x = parseFloat(a[_tempColunaAOrdenar].valor);
			y = parseFloat(b[_tempColunaAOrdenar].valor);
			if (x > y) { return -_tempOrdem; }
			if (x < y) { return _tempOrdem; }
			else { return 0; }
    		} else {
			// Texto.
			valor1 = retiraAcentos(a[_tempColunaAOrdenar].valor);
			valor2 = retiraAcentos(b[_tempColunaAOrdenar].valor);
			if (valor1 < valor2) { return -_tempOrdem; }
			if (valor1 > valor2) { return _tempOrdem; }
			else { return 0; }
		}
	};

	this.mostraListagem = function() {
		listagem = "<span id='tabelaListagem" + this.nomeVariavel + "' align=\"left\">";
		listagem += this.montaListagem();
		listagem += "</span><br />";
		document.write(listagem);
	};

	this.montaListagem  = function() {
		// Monta a descrição da tabela.
		listagem = "<table align=\"left\" class=\"MsoTableGrid\" style=\"border: 0; padding-right: 10pt; padding-bottom: 2pt; padding-top: 0; background-color: transparent; mso-border-left-alt: windowtext .5pt; mso-border-top-alt: windowtext .5pt; mso-border-bottom-alt: silver .25pt; mso-border-right-alt: silver .25pt; mso-border-style-alt: solid; border-collapse: collapse; border-top-color: #C0C0C0\" border=\"0\" cellspacing=\"0\" bordercolor=\"#c0c0c0\" cellpadding=\"4\">";
		// Monta o título.
		var i = 0;
		var j = 0;

		listagem += "<tr class=\"AreaConteudoListaInfoTitulo\">";
		for (i = 0; i < this.vetorColunas.length; i++) {
			if (this.vetorColunas[i].ordenacao == true) {
				listagem +=
					"<td align=\"" + this.vetorColunas[i].alinhamento + "\">" +
						"<font face=\"Arial\" size=\"2\">" +
							this.vetorColunas[i].icone +
							"<a href=\"javascript:" + this.nomeVariavel + ".reOrdenarTabela(" + i + ")\" class=\"linkVermelho\">" +
								"<b>" + this.vetorColunas[i].titulo + "</b>" +
							"</a>" +
						"</font>" +
					"</td>";
			} else {
				listagem +=
					"<td align=\"" + this.vetorColunas[i].alinhamento + "\">" +
						"<font face=\"Arial\" size=\"2\">" +
							"<span class=\"linkVermelho\">" +
								"<b>" + this.vetorColunas[i].icone + this.vetorColunas[i].titulo + "</b>" +
							"</span>" +
						"<font>" +
					"</td>";
			}
		}

		// Monta as linhas.
		for (i = 0; i < this.vetorLinhas.length; i++) {
			if (i % 2 != 0) {
				listagem += "<tr bgcolor=\"#C7E0E0\">";
			} else {
				listagem += "<tr>";
			}

			for (j = 0; j < this.vetorLinhas[i].length; j++) {
				listagem +=
					"<td align=\"" + this.vetorColunas[j].alinhamento + "\">" +
						"<font face=\"Arial\" size=\"2\">" +
							// (j == 0 && i != this.vetorLinhas.length) ? (i + 1) + ". " : "" +
							this.vetorLinhas[i][j].exibicao +
						"<font>" +
					"</td>";
			}
		}
		// Fim da tabela
		listagem += "</table>";

		return listagem;
	};
}

function retiraAcentos(str) {
   	str = str.replace(/Á/gi, 'A');
   	str = str.replace(/É/gi, 'E');
   	str = str.replace(/Í/gi, 'I');
   	str = str.replace(/Ó/gi, 'O');
   	str = str.replace(/Ú/gi, 'U');
   	return str;
}

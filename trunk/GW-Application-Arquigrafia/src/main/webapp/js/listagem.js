/////////////// Manipulação de listagens //////////////////////

function ordenacaoAlfabetica(a, b) {
    var y = retiraAcentos(a);
    var x = retiraAcentos(b);
    return (x < y) ? -1 : (x > y) ? 1 : 0;
}

function ordenacaoNumerica(a, b) {
    var x = parseFloat(a);
    var y = parseFloat(b);
    return (x < y) ? -1 : (x > y) ? 1 : 0;
}

// Objetos
function Coluna(titulo, esquerda, comparador, icone) {
    this.titulo = titulo;
    this.esquerda = esquerda;
    this.comparador = comparador;
    this.icone = icone;

    this.renderizar = function(elem, clickCallback) {
        if (this.icone != null) {
            var iconeImg = $("<img></img>");
            elem.append(this.icone);
            iconeImg.attr("src", this.icone);
        }

        var inner = (this.comparador != null) ? $("<a></a>") : $("<span></span>");
        elem.append(inner);
        inner.html(this.titulo);

        if (this.comparador != null) inner.click(clickCallback);
    };
}

function ColunaOpcoes(titulo, icone, msgDelete, targetDelete, srcImgEdit, srcImgDelete) {
    this.titulo = titulo;
    this.icone = icone;
    this.srcImgEdit = srcImgEdit;
    this.srcImgDelete = srcImgDelete;
    this.msgDelete = msgDelete;
    this.targetDelete = targetDelete;
    this.comparador = null;

    this.renderizar = function(elem, clickCallback) {
        if (this.icone != null) {
            var iconeImg = $("<img></img>");
            elem.append(iconeImg);
            iconeImg.attr("src", this.icone);
            iconeImg.attr("alt", this.titulo);
        }

        var inner = $("<span></span>");
        elem.append(inner);
        inner.html(this.titulo);
    };
}

function Celula(exibicao, valor) {
    this.exibicao = exibicao;
    this.valor = valor;

    this.renderizar = function(coluna, elem) {
        elem.css({"text-align": coluna.esquerda ? "left" : "right"});
        elem.html(this.exibicao);
    };
}

function CelulaCallback(callback) {
    this.callback = callback;

    this.renderizar = function(coluna, elem) {
        this.callback(this, coluna, elem);
    };
}

function CelulaOpcoes(hrefEdit, hrefDelete) {
    // Importante, pois às vezes o "this" pode apontar para objetos inesperados (em especial com o jQuery).
    var eu = this;

    eu.hrefEdit = hrefEdit;
    eu.hrefDelete = hrefDelete;

    function remover(coluna) {
        if (!confirm(coluna.msgDelete)) return;

        $.post(eu.hrefDelete,
            { _method: 'DELETE'},
            function(data) {
                window.open(coluna.targetDelete, '_self');
                window.location.reload(true);
                return false;
            }
        );
    }

    eu.renderizar = function(coluna, elem) {
        var linkEdit = $("<a></a>");
        linkEdit.attr("href", eu.hrefEdit);
        elem.append(linkEdit);
        elem.append(" | ");

        if (coluna.srcImgEdit != null) {
            var iconeEdit = $("<img></img>");
            linkEdit.append(iconeEdit);
            iconeEdit.attr("src", coluna.srcImgEdit);
            iconeEdit.attr("alt", "editar");
        } else {
            linkEdit.html("Editar");
        }

        var linkDelete = $("<a></a>");
        linkDelete.attr("href", "javascript:void(0); ");
        linkDelete.click(function() { remover(coluna); });
        elem.append(linkDelete);

        if (coluna.srcImgDelete != null) {
            var iconeDelete = $("<img></img>");
            linkDelete.append(iconeDelete);
            iconeDelete.attr("src", coluna.srcImgDelete);
            iconeDelete.attr("alt", "deletar");
        } else {
            linkDelete.html("Excluir");
        }
    };
}

function TabelaConfig(url, texto, msgVazio) {

    // Importante, pois às vezes o "this" pode apontar para objetos inesperados (em especial com o jQuery).
    var eu = this;

    eu.url = url;
    eu.texto = texto;
    eu.msgVazio = msgVazio;

    eu.renderizarAdd = function(elem) {
        var botao = $("<input type='button' />");
        botao.addClass("botao");
        botao.attr("value", eu.texto);
        botao.click(function(evt) {
            window.location.href = eu.url;
        });
        elem.append(botao);
    };
}

function Tabela(config) {
    // Importante, pois às vezes o "this" pode apontar para objetos inesperados (em especial com o jQuery).
    var eu = this;

    eu.colunas = new Array();
    eu.linhas = new Array();
    eu.config = config;

    var ultimaLinha = null;

    // Atributos privados para se comunicar com a função de comparação.
    var ordemDaColunaAOrdenar; // Ordem é 1 para crescente e -1 para decrescente
    var colunaAOrdenar = undefined;

    eu.addColunaSimples = function(titulo) {
        eu.colunas[eu.colunas.length] = new Coluna(titulo, true, ordenacaoAlfabetica, null);
    };

    eu.addColuna = function(titulo, alinhamento, ordenacao, icone) {
        eu.colunas[eu.colunas.length] = new Coluna(titulo, alinhamento, ordenacao, icone);
    };

    eu.addColunas = function(titulos) {
        for (var i in titulos) {
            eu.addColunaSimples(titulos[i]);
        }
    };

    eu.addColunaOpcoes = function(titulo, icone, msgDelete, targetDelete, srcImgEdit, srcImgDelete) {
        eu.colunas[eu.colunas.length] = new ColunaOpcoes(titulo, icone, msgDelete, targetDelete, srcImgEdit, srcImgDelete);
    };

    eu.addCelula = function(exibicao) {
        eu.addCelulaElemento(new Celula(exibicao, exibicao));
    };

    eu.addCelulas = function(exibicoes) {
        for (var exibicao in exibicoes) {
            eu.addCelula(exibicoes[exibicao]);
        }
    };

    eu.addCelula2 = function(exibicao, valorReal) {
        eu.addCelulaElemento(new Celula(exibicao, valorReal));
    };

    eu.addCelulaOpcoes = function(hrefEdit, hrefDelete) {
        eu.addCelulaElemento(new CelulaOpcoes(hrefEdit, hrefDelete));
    };

    eu.addCelulaElemento = function(celula) {
        if (ultimaLinha == null || ultimaLinha.length == eu.colunas.length) {
            criarNovaLinha();
        }
        ultimaLinha[ultimaLinha.length] = celula;
    };

    function criarNovaLinha() {
        eu.linhas[eu.linhas.length] = ultimaLinha = new Array();
    }

    function reordenarTabela(coluna) {
        // -ordemDaColunaAOrdenar = Inverte a ordenação.
        ordemDaColunaAOrdenar = (colunaAOrdenar == coluna) ? -ordemDaColunaAOrdenar : 1;

        colunaAOrdenar = coluna;
        eu.linhas.sort(function(a, b) {
            return eu.colunas[coluna].comparador(a[coluna].valor, b[coluna].valor) * ordemDaColunaAOrdenar;
        });
    }

    function callbackReordenar(col, destino) {
        return function(evt) {
            reordenarTabela(col);
            eu.mostraListagem(destino);
        };
    }

    eu.mostraListagem = function(destino) {

        // Limpa o conteúdo atual da área da tabela.
        destino.empty();
        destino.css({"text-align": "left"});

        // Cria a tabela, se ela não estiver vazia.
        if (eu.linhas.length > 0) {

            // Cria a tabela.
            var tabela = $("<table></table>");
            tabela.css({
                "text-align": "left",
                "border": 0,
                "padding-right": "10pt",
                "padding-bottom": "2pt",
                "adding-top": 0,
                "background-color": "transparent",
                "border-collapse": "collapse",
                "border-top-color": "#C0C0C0"
            });

            // Cria a linha que contém os cabeçalhos.
            var trTitulos = $("<tr></tr>");
            tabela.append(trTitulos);
            trTitulos.addClass("tabela-listagem-linha-titulo");

            // Cria os cabeçalhos.
            for (var col = 0; col < eu.colunas.length; col++) {
                var th = $("<th></th>");
                trTitulos.append(th);
                this.colunas[col].renderizar(th, callbackReordenar(col, destino));
            }

            // Cria as linhas.
            for (var i = 0; i < eu.linhas.length; i++) {
                var trAtual = $("<tr></tr>");
                tabela.append(trAtual);
                trAtual.addClass((i % 2 == 0) ? "tabela-listagem-linha-par" : "tabela-listagem-linha-impar")

                for (var j = 0; j < eu.linhas[i].length; j++) {
                    var td = $("<td></td>");
                    trAtual.append(td);
                    eu.linhas[i][j].renderizar(eu.colunas[j], td);
                }
            }

            destino.append(tabela);

        // Se a tabela estiver vazia, acrescenta uma mensagem dizendo isso.
        } else {
            var msgVazio = (eu.config == null) ? "Não existe nenhum elemento a ser mostrado." : eu.config.msgVazio;
            var div = $("<div></div>");
            var span = $("<span></span>");
            span.html(msgVazio);
            div.append(span);
            destino.append(div);
        }

        // Cria o botão de adicionar.
        var divAdd = (eu.config == null) ? null : $("<div></div>");
        if (eu.config != null) {
            divAdd.css({
                "clear": "both",
                "padding-top": "8px"
            });
            eu.config.renderizarAdd(divAdd);
            destino.append(divAdd);
        }

        // Finaliza a montagem.
        return destino;
    }
}

function defaultTitleProcess(tabela, coluna) {
    tabela.addColunaSimples(coluna);
}

function defaultCellProcess(tabela, coluna) {
    tabela.addCelula(coluna);
}

function retiraAcentos(str) {
    str = str.replace(/[ÁáÂâÀàÄäÃã]/gi, 'A');
    str = str.replace(/[Çç]/gi, 'C');
    str = str.replace(/[ÉéÊêÈèËë]/gi, 'E');
    str = str.replace(/[ÍíÎîÌìÏï]/gi, 'I');
    str = str.replace(/[Ññ]/gi, 'N');
    str = str.replace(/[ÓóÔôÒòÖöÕõ]/gi, 'O');
    str = str.replace(/[ÚúÛûÙùÜü]/gi, 'U');
    str = str.replace(/[Ýýÿ]/gi, 'Y');
    return str;
}

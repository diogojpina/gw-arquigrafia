// JavaScript Document
$(function() {
    // abas
    // oculta todas as abas
    $("div.contaba").hide();
    // mostra somente  a primeira aba
    $("div.contaba:first").show();
    // seta a primeira aba como selecionada (na lista de abas)
    $("#tabs a:first").addClass("selected");
    // quando clicar no link de uma aba
    $("#tabs a").click(function() {
        // oculta todas as abas
        $("div.contaba").hide();
        // tira a seleção da aba atual
        $("#tabs a").removeClass("selected");

        // adiciona a classe selected na selecionada atualmente
        $(this).addClass("selected");
        // mostra a aba clicada
        $($(this).attr("href")).show();
        // pra nao ir para o link
        return false;
    });
});
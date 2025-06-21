document.addEventListener("DOMContentLoaded", () => {
  const carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];
  const tabela = document.getElementById("carrinho-tabela");
  const valorTotal = document.getElementById("valor-total");
  let total = 0;

  function atualizarCarrinho() {
    tabela.innerHTML = "";
    total = 0;

    carrinho.forEach((item, index) => {
      const subtotal = item.quantidade * item.preco;
      total += subtotal;

      const linha = document.createElement("tr");
      linha.innerHTML = `
        <td style="padding: 10px;">${item.nome}</td>
        <td>R$ ${item.preco.toFixed(2)}</td>
        <td><input type="number" id="quantidade-${index}" value="${item.quantidade}" min="1" max="99" onchange="atualizarQuantidade(${index}, this.value)"></td>
        <td>R$ ${subtotal.toFixed(2)}</td>
        <td><button onclick="removerItem(${index})">Remover</button></td>
      `;
      tabela.appendChild(linha);
    });

    valorTotal.textContent = `Valor total: R$ ${total.toFixed(2)}`;
    localStorage.setItem("carrinho", JSON.stringify(carrinho));
  }

  window.atualizarQuantidade = function(index, novaQuantidade) {
    carrinho[index].quantidade = parseInt(novaQuantidade);
    localStorage.setItem("carrinho", JSON.stringify(carrinho));
    atualizarCarrinho();
  }

  window.removerItem = function(index) {
    carrinho.splice(index, 1);
    atualizarCarrinho();
  }

  atualizarCarrinho();
});

// Finalizar compra
const finalizarCompraButton = document.querySelector('button');

finalizarCompraButton.addEventListener('click', () => {
  document.getElementById('modal-container').style.display = 'block';
});

const modalContainer = document.getElementById('modal-container');
const modalClose = document.getElementById('modal-close');
const avaliacaoForm = document.getElementById('avaliacao-form');

modalClose.addEventListener('click', finalizarCompra);

window.addEventListener('click', (event) => {
  if (event.target === modalContainer) {
    finalizarCompra();
  }
});

avaliacaoForm.addEventListener('submit', (event) => {
  event.preventDefault();
  const rating = document.querySelector('input[name="rating"]:checked')?.value;
  const formaPagamento = document.getElementById('forma-pagamento').value;
  
  if (rating) {
    alert(`Obrigado por avaliar!`);
    finalizarCompra(rating, formaPagamento);
  } else {
    alert('Por favor, selecione uma nota.');
  }
});

function finalizarCompra(rating = null, formaPagamento = null) {

  modalContainer.style.display = 'none';

  const carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];
  const itens = [];

  carrinho.forEach(item => {
    const total = item.preco * item.quantidade;
    itens.push({...item, total});
  });

  // Envia os itens para o arquivo carrinho.php para cadastrar no banco
  fetch('../back-end/carrinho.php', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ itens, rating, formaPagamento })
  })
    .then(response => {
      if (response.ok) {
        return response.text();
      } else if (response.status == 401) {
        alert('Usuário não autenticado. Favor logar novamente.');
        location.href = 'login.html';
      } else {
        throw new Error('Erro ao encaminhar os itens e nota para o carrinho.');
      }
    })
    .then((data) => {
      localStorage.removeItem('carrinho');
      document.getElementById('modal-notifica-envio').style.display = 'block';
      document.getElementById('protocolo-compra').textContent = data;// encaminhar data para email.php
      console.log(data);
        // Envia o protocolo para o arquivo email.php
        fetch('../back-end/email.php', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({ data })
        })
          .then(response => {
            if (response.ok) {
              console.log('Protocolo enviado com sucesso!');
            } else {
              throw new Error('Erro ao enviar protocolo para email.php');
            }
          })
          .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
          });

      document.getElementById('modal-notifica-envio-close').addEventListener('click', () => {
        document.getElementById('modal-notifica-envio').style.display = 'none';
        //Redirecionamento
        location.href = 'loja.html';
      });
    })
    .catch(error => {
      console.error('There was a problem with the fetch operation:', error);
    });
}

finalizarCompraButton.addEventListener('click', () => {
  if (carrinhoEstaVazio()) {
    alert('O carrinho está vazio. Adicione produtos para finalizar a compra.');
    document.getElementById('modal-container').style.display = 'none';
  } 
});

function carrinhoEstaVazio() {
  const carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];
  return carrinho.length === 0;
}
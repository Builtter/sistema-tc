document.addEventListener("DOMContentLoaded", () => {
  // Rolar suavemente
  document.querySelectorAll("nav a").forEach(link => {
    link.addEventListener("click", e => {
      if (link.getAttribute("href").startsWith("#")) {
        e.preventDefault();
        const target = document.querySelector(link.getAttribute("href"));
        target?.scrollIntoView({ behavior: "smooth" });
      }
    });
  });



    // let index = 0;
    // const banner = document.querySelector(".banner img");
    // setInterval(() => {
    //   index = (index + 1) % imagens.length;
    //   banner.src = imagens[index];
    // }, 4000);

  // Botão de modo escuro
  const botaoModo = document.getElementById("modo-escuro-toggle");
  if (botaoModo) {
    botaoModo.addEventListener("click", () => {
      document.body.classList.toggle("dark-mode");
      botaoModo.textContent = document.body.classList.contains("dark-mode")
        ? "☀️ Modo Claro" : "🌙 Modo Escuro";
    });
  }

  // Adicionar produto ao carrinho
  const botoes = document.querySelectorAll(".add-carrinho");
  botoes.forEach(botao => {
    botao.addEventListener("click", () => {
      const nome = botao.dataset.nome;
      const preco = parseFloat(botao.dataset.preco);
      const id = botao.dataset.id;

      let carrinho = JSON.parse(localStorage.getItem("carrinho")) || [];
      const existente = carrinho.find(item => item.id === id);

      if (existente) {
        existente.quantidade += 1;
      } else {
        carrinho.push({ id, nome, preco, quantidade: 1 });
      }

      localStorage.setItem("carrinho", JSON.stringify(carrinho));
      alert(`"${nome}" foi adicionado ao carrinho!`);
    });
  });
});

document.addEventListener('turbolinks:load', () => {
  // Fonction pour gérer les événements mouseenter et mouseleave
  const handleMouseEvents = (item) => {
    item.addEventListener('mouseenter', (event) => {
      const ball = event.currentTarget.querySelector('i');
      const title = event.currentTarget.querySelector('p');

      showElement(ball, title)
    });

    item.addEventListener('mouseleave', (event) => {
      const ball = event.currentTarget.querySelector('i');
      const title = event.currentTarget.querySelector('p');
      hideElement(ball, title)
    });
  };

  // Appliquer la gestion des événements à chaque élément avec la classe home-menu-list-item
  document.querySelectorAll('.home-menu-list-item').forEach((item) => {
    handleMouseEvents(item);
  });

  // Fonctions de gestion d'animation
  const showElement = (ball, title) => {
    title.classList.add('title-hover');
    ball.classList.remove('invisible');
    ball.classList.add('ball-hover');
  };

  const hideElement = (ball, title) => {
    ball.classList.add('invisible');
    ball.classList.remove('ball-hover');
    title.classList.remove('title-hover');
  };
});

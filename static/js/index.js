let currentIndex = 0;
  const images = [
    '{% static "images/dala.jpg" %}',
    '{% static "images/sakaja.jpg" %}',
    '{% static "images/siaya.jpg" %}',
    // Add more image URLs as needed
  ];

  function changeSlide() {
    currentIndex = (currentIndex + 1) % images.length;
    document.querySelector('#carouselExampleDark img').src = images[currentIndex];
  }

  setInterval(changeSlide, 5000);
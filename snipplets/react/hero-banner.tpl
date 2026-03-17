<div id="react-hero-banner"></div>

<script>
  window.addEventListener('load', function() {
      if (!window.renderZaleskiHeroCarousel) {
          console.error('[Zaleski Widgets] React bundle is missing or render function not found.');
          return;
      }
      
      var customSlides = [];
      
      {% if 'zaleski_hero_image_1.jpg' | has_custom_image %}
      customSlides.push({
          image: "{{ 'zaleski_hero_image_1.jpg' | static_url }}",
          title: "{{ settings.zaleski_hero_title_1 | escape('js') }}",
          subtitle: "{{ settings.zaleski_hero_subtitle_1 | escape('js') }}",
          buttonText: "{{ settings.zaleski_hero_button_text_1 | escape('js') }}",
          buttonHref: "{{ settings.zaleski_hero_button_url_1 | escape('js') }}",
          tag: "Destaque"
      });
      {% endif %}

      {% if 'zaleski_hero_image_2.jpg' | has_custom_image %}
      customSlides.push({
          image: "{{ 'zaleski_hero_image_2.jpg' | static_url }}",
          title: "{{ settings.zaleski_hero_title_2 | escape('js') }}",
          subtitle: "{{ settings.zaleski_hero_subtitle_2 | escape('js') }}",
          buttonText: "{{ settings.zaleski_hero_button_text_2 | escape('js') }}",
          buttonHref: "{{ settings.zaleski_hero_button_url_2 | escape('js') }}",
          tag: "Destaque"
      });
      {% endif %}

      {% if 'zaleski_hero_image_3.jpg' | has_custom_image %}
      customSlides.push({
          image: "{{ 'zaleski_hero_image_3.jpg' | static_url }}",
          title: "{{ settings.zaleski_hero_title_3 | escape('js') }}",
          subtitle: "{{ settings.zaleski_hero_subtitle_3 | escape('js') }}",
          buttonText: "{{ settings.zaleski_hero_button_text_3 | escape('js') }}",
          buttonHref: "{{ settings.zaleski_hero_button_url_3 | escape('js') }}",
          tag: "Destaque"
      });
      {% endif %}

      window.renderZaleskiHeroCarousel('react-hero-banner', customSlides.length > 0 ? customSlides : null);
  });
</script>

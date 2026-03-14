<div 
  id="react-hero-banner"
  data-title="{{ settings.zaleski_hero_title }}"
  data-subtitle="{{ settings.zaleski_hero_subtitle }}"
  data-button-text="{{ settings.zaleski_hero_button_text }}"
  data-button-url="{{ settings.zaleski_hero_button_url }}"
  data-image-url="{{ 'zaleski_hero_image.jpg' | has_custom_image ? 'zaleski_hero_image.jpg' | static_url : '' }}"
></div>

<script>
  window.addEventListener('load', function() {
      if (window.renderZaleskiHeroCarousel) {
          window.renderZaleskiHeroCarousel('react-hero-banner');
      } else {
          console.error('[Zaleski Widgets] React bundle is missing or render function not found.');
      }
  });
</script>

{% snipplet "react/react-bundle.tpl" %}
{# snipplets/home/home-hero.tpl #}
{% if settings.show_hero_banner %}
    <section class="zaleski-hero-section" data-transition="fade-in-up">
        {% if settings.hero_button_url %}
            <a href="{{ settings.hero_button_url | setting_url }}" class="zaleski-hero-link" aria-label="{{ settings.hero_title | default('Hero Banner') }}">
        {% endif %}

        <div class="zaleski-hero-container">
            {# Imagem Desktop — carregamento prioritário (LCP) #}
            {% if "hero_image_desktop.jpg" | has_custom_image %}
                <img
                    src="{{ 'hero_image_desktop.jpg' | static_url | settings_image_url('1080p') }}"
                    class="zaleski-hero-img zaleski-hero-img-desktop"
                    alt="{{ settings.hero_title | default(store.name) }}"
                    fetchpriority="high"
                />
            {% endif %}

            {# Imagem Mobile — carregamento prioritário (LCP) #}
            {% if "hero_image_mobile.jpg" | has_custom_image %}
                <img
                    src="{{ 'hero_image_mobile.jpg' | static_url | settings_image_url('huge') }}"
                    class="zaleski-hero-img zaleski-hero-img-mobile"
                    alt="{{ settings.hero_title | default(store.name) }}"
                    fetchpriority="high"
                />
            {% endif %}

            {# Overlay escuro sobre a imagem #}
            <div class="zaleski-hero-overlay" style="background-color: rgba(0,0,0,{{ settings.hero_overlay_opacity | default('0.4') }});"></div>

            {# Conteúdo de texto e botão #}
            <div class="zaleski-hero-content">
                {% if settings.hero_title %}
                    <h2 class="zaleski-hero-title">{{ settings.hero_title }}</h2>
                {% endif %}

                {% if settings.hero_subtitle %}
                    <p class="zaleski-hero-subtitle">{{ settings.hero_subtitle }}</p>
                {% endif %}

                {% if settings.hero_button_text and settings.hero_button_url %}
                    <span class="zaleski-hero-btn">{{ settings.hero_button_text }}</span>
                {% endif %}
            </div>
        </div>

        {% if settings.hero_button_url %}
            </a>
        {% endif %}
    </section>
{% endif %}

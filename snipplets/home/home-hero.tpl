{% set has_hero_desktop = "hero_image_desktop.jpg" | has_custom_image %}
{% set has_hero_mobile = "hero_image_mobile.jpg" | has_custom_image %}

{% if settings.show_hero_banner and (has_hero_desktop or has_hero_mobile) %}
    <section class="zaleski-hero" data-store="home-hero">
        <div class="zaleski-hero-container">
            
            {# Imagens de fundo #}
            <picture class="zaleski-hero-picture">
                {% if has_hero_mobile %}
                    <source media="(max-width: 767px)" srcset="{{ "hero_image_mobile.jpg" | static_url | img_url('large') }}">
                {% endif %}
                {% if has_hero_desktop %}
                    <img src="{{ "hero_image_desktop.jpg" | static_url | img_url('1920x1080') }}" 
                         alt="{{ settings.hero_title | default(store.name) }}" 
                         class="zaleski-hero-img">
                {% endif %}
            </picture>

            {# Overlay configurável #}
            <div class="zaleski-hero-overlay" style="background-color: rgba(0,0,0, {{ settings.hero_overlay_opacity | default('0.4') }});"></div>

            {# Conteúdo centralizado #}
            <div class="zaleski-hero-content container">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-8 text-center">
                        {% if settings.hero_title %}
                            <h1 class="zaleski-hero-title mb-3">{{ settings.hero_title }}</h1>
                        {% endif %}
                        
                        {% if settings.hero_subtitle %}
                            <p class="zaleski-hero-subtitle mb-4">{{ settings.hero_subtitle }}</p>
                        {% endif %}

                        {% if settings.hero_button_text and settings.hero_button_url %}
                            <a href="{{ settings.hero_button_url | setting_url }}" class="btn btn-primary zaleski-hero-btn">
                                {{ settings.hero_button_text }}
                            </a>
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </section>
{% endif %}
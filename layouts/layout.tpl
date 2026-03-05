<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}" class="no-js">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style" />

        {# Preload LCP home, category and product #}
        {% if template == 'home' and settings.slider and settings.slider is not empty %}
            <link rel="preload" as="image" href="{{ settings.slider.0.image | static_url | img_url('large') }}" imagesrcset="{{ settings.slider.0.image | static_url | img_url('medium') }} 600w, {{ settings.slider.0.image | static_url | img_url('large') }} 1000w, {{ settings.slider.0.image | static_url | img_url('huge') }} 1400w" imagesizes="100vw">
        {% endif %}
        {% if template == 'category' and products %}
            <link rel="preload" as="image" href="{{ products.0.featured_image | img_url('large') }}" imagesrcset="{{ products.0.featured_image | img_url('medium') }} 600w, {{ products.0.featured_image | img_url('large') }} 1000w, {{ products.0.featured_image | img_url('huge') }} 1400w" imagesizes="(min-width: 768px) 33vw, 50vw">
        {% endif %}
        {% if template == 'product' %}
            <link rel="preload" as="image" href="{{ product.featured_image | img_url('large') }}" imagesrcset="{{ product.featured_image | img_url('medium') }} 600w, {{ product.featured_image | img_url('large') }} 1000w, {{ product.featured_image | img_url('huge') }} 1400w" imagesizes="(min-width: 768px) 50vw, 100vw">
        {% endif %}

        {% if settings.font_headings %}
            {{ settings.font_headings | google_fonts_url('400,700') | stylesheet_tag }}
        {% endif %}
        {% if settings.font_rest %}
            {{ settings.font_rest | google_fonts_url('400,700') | stylesheet_tag }}
        {% endif %}

        {{ 'css/style-critical.scss' | static_url | stylesheet_tag }}
        {{ 'css/style-colors.scss' | static_url | stylesheet_tag }}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        <style>
            {{ settings.css_code | raw }}
        </style>

        {{ header_logos_etc[0] | raw }}
        {{ header_logos_etc[1] | raw }}
        {{ header_logos_etc[2] | raw }}
        {{ header_logos_etc[3] | raw }}

        {# Social medium tags #}
        {% include "snipplets/social/social-share.tpl" %}

        {# Structured data #}
        {% include "snipplets/social/social-links.tpl" %}
    </head>

    <body class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">
        
        {# Zaleski: Announcement Bar Marquee #}

        {% if settings.show_announcement_bar %}
            <div class="zaleski-announcement-bar" style="background: {{ settings.color_marquee_bg }}; color: {{ settings.color_marquee_text }};">
                <div class="zaleski-marquee-wrapper">
                    <div class="zaleski-marquee-content" style="animation-duration: {{ settings.marquee_speed | default('25s') }};">
                        {% for i in 1..2 %} {# Duplicado para loop infinito sem falhas #}
                        <div class="zaleski-marquee-group">
                            {% if settings.announcement_text_1 %}
                                <span class="zaleski-marquee-item">{{ settings.announcement_text_1 }}</span>
                                <span class="zaleski-marquee-sep">·</span>
                            {% endif %}
                            {% if settings.announcement_text_2 %}
                                <span class="zaleski-marquee-item">{{ settings.announcement_text_2 }}</span>
                                <span class="zaleski-marquee-sep">·</span>
                            {% endif %}
                            {% if settings.announcement_text_3 %}
                                <span class="zaleski-marquee-item">{{ settings.announcement_text_3 }}</span>
                                <span class="zaleski-marquee-sep">·</span>
                            {% endif %}
                            {% if settings.announcement_text_4 %}
                                <span class="zaleski-marquee-item">{{ settings.announcement_text_4 }}</span>
                                <span class="zaleski-marquee-sep">·</span>
                            {% endif %}
                        </div>
                        {% endfor %}
                    </div>
                </div>
            </div>
        {% endif %}

        {% include "snipplets/header/header.tpl" %}

        <main id="main" class="main-content" data-store="main-content">
            {{ template_content }}
        </main>

        {% include "snipplets/footer/footer.tpl" %}

        {% include "snipplets/notification.tpl" %}

        {% if settings.whatsapp_chat_number %}
            {% include "snipplets/whatsapp-chat.tpl" %}
        {% endif %}

        <script>
            {% include "static/js/external-no-dependencies.js.tpl" %}
            LS.ready.then(function(){
                {% include "static/js/external.js.tpl" %}
                {% include "static/js/store.js.tpl" %}
            });
        </script>

        {% if template == 'account.register' %}
            {% if not store.hasContactFormsRecaptcha() % Parágrafo %}
                {{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
            {% endif %}
            <script type="text/javascript">
                var recaptchaCallback = function() {
                    jQueryNuvem('.js-recaptcha-button').prop('disabled', false);
                };
            </script>
        {% endif %}

        {{ component('google-survey') }}

        {% if store.assorted_js %}
            <script>
                LS.ready.then(function() {
                    var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
                    jQueryNuvem('body').append(trackingCode);
                });
            </script>
        {% endif %}
    </body>
</html>
{% if settings.show_category_banners %}
<section class="zaleski-category-banners">
    <div class="container">
        <div class="row">
            {# Loop através dos banners (1 e 2) #}
            {% for i in (1..2) %}
                {% assign cat_img = 'cat_' | append: i | append: '_img' %}
                {% assign cat_url = 'cat_' | append: i | append: '_url' %}
                {% assign cat_title = 'cat_' | append: i | append: '_title' %}
                {% assign cat_subtitle = 'cat_' | append: i | append: '_subtitle' %}
                {% assign cat_btn = 'cat_' | append: i | append: '_btn' %}
                
                {% if settings[cat_img] %}
                <div class="col-md-6 zaleski-banner-col">
                    <a href="{{ settings[cat_url] | default('#') }}" class="zaleski-banner-link">
                        <div class="zaleski-banner-image-wrapper">
                            <img src="{{ 'static/images/empty-placeholder.png' | static_url }}" 
                                 data-src="{{ settings[cat_img] | static_url }}" 
                                 alt="{{ settings[cat_title] | default: 'Banner ' | append: i }}" 
                                 class="zaleski-banner-img lazyload">
                            <div class="zaleski-banner-overlay"></div>
                        </div>
                        <div class="zaleski-banner-content">
                            {% if settings[cat_subtitle] %}
                                <p class="zaleski-banner-subtitle">{{ settings[cat_subtitle] }}</p>
                            {% endif %}
                            {% if settings[cat_title] %}
                                <h2 class="zaleski-banner-title">{{ settings[cat_title] }}</h2>
                            {% endif %}
                            {% if settings[cat_btn] %}
                                <span class="zaleski-banner-btn">{{ settings[cat_btn] }}</span>
                            {% endif %}
                        </div>
                    </a>
                </div>
                {% endif %}
            {% endfor %}
        </div>
    </div>
</section>
{% endif %}
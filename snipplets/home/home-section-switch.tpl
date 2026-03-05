{% if section_select == 'slider' %}

	{#  **** Home slider **** #}

	{% set head_transparent_section = (has_main_slider or has_mobile_slider) and settings.head_transparent % prayers %}

	<section class="section-slider-home" data-store="home-slider" {% if head_transparent_section %}data-header-type="transparent-on-section"{% endif %}>
		{% if show_help or (show_component_help and not (has_main_slider or has_mobile_slider)) % prayers %}
			{% snipplet 'defaults/home/slider_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-slider.tpl' %}
			{% if has_mobile_slider %}
				{% include 'snipplets/home/home-slider.tpl' with {mobile: true} %}
			{% endif %}
		{% endif %}
	</section>

{# Adição do Hero Banner Zaleski #}
{% elseif section_select == 'hero' %}
    {% include 'snipplets/home/home-hero.tpl' %}

{% elseif section_select == 'main_categories' %}

	{#  **** Main categories **** #}
	{% if show_help or (show_component_help and not has_main_categories) %}
		{% snipplet 'defaults/home/main_categories_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-categories.tpl' %}
	{% endif %}

{% elseif section_select == 'products' %}

	{#  **** Featured products **** #}
	{% if show_help or (show_component_help and not has_products) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Destacados' | translate, section: 'products' } %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with { products_title: settings.products_title, section: 'products' } %}
	{% endif %}

{% elseif section_select == 'informatives' %}

	{#  **** Informative banners **** #}
	{% if show_help or (show_component_help and not has_informative_banners) %}
		{% include 'snipplets/defaults/home/informative_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/banner-services/banner-services.tpl' %}
	{% endif %}

{% elseif section_select == 'categories' %}

	{#  **** Banners with text **** #}
	{% if show_help or (show_component_help and not has_banners) %}
		{% include 'snipplets/defaults/home/category_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-banners.tpl' %}
	{% endif %}

{% elseif section_select == 'new' %}

	{#  **** New products **** #}
	{% if show_help or (show_component_help and not has_new) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Lanzamientos' | translate, section: 'new' } %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with { products_title: settings.new_title, section: 'new' } %}
	{% endif %}

{% elseif section_select == 'video' %}

	{#  **** Video section **** #}
	{% if show_help or (show_component_help and not has_video) %}
		{% include 'snipplets/defaults/home/video_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-video.tpl' %}
	{% endif %}

{% elseif section_select == 'sale' %}

	{#  **** Sale products **** #}
	{% if show_help or (show_component_help and not has_sale) %}
		{% include 'snipplets/defaults/home/featured_products_help.tpl' with { products_title: 'Ofertas' | translate, section: 'sale' } %}
	{% else %}
		{% include 'snipplets/home/home-featured-products.tpl' with { products_title: settings.sale_title, section: 'sale' } %}
	{% endif %}

{% elseif section_select == 'main_product' %}

	{#  **** Featured product **** #}
	{% if show_help or (show_component_help and not has_main_product) %}
		{% include 'snipplets/defaults/home/main_product_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-main-product.tpl' %}
	{% endif %}

{% elseif section_select == 'instafeed' %}

	{#  **** Instagram feed **** #}
	{% if show_help or (show_component_help and not has_instafeed) %}
		{% include 'snipplets/defaults/home/instafeed_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-instafeed.tpl' %}
	{% endif %}

{% elseif section_select == 'promotional' %}

	{#  **** Promotional banners **** #}
	{% if show_help or (show_component_help and not has_promotional_banners) %}
		{% include 'snipplets/defaults/home/promotional_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-banners.tpl' with {promotional: true} %}
	{% endif %}

{% elseif section_select == 'news_banners' %}

	{#  **** News banners **** #}
	{% if show_help or (show_component_help and not has_news_banners) %}
		{% include 'snipplets/defaults/home/news_banners_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-banners-grid.tpl' %}
	{% endif %}

{% elseif section_select == 'newsletter' %}

	{#  **** Newsletter section **** #}
	{% include 'snipplets/home/home-newsletter.tpl' %}

{% elseif section_select == 'welcome' %}

	{#  **** Welcome message **** #}
	{% if show_help or (show_component_help and not has_welcome_message) %}
		{% include 'snipplets/defaults/home/welcome_message_help.tpl' with { section: 'welcome', title: 'Mensaje de bienvenida' | translate, data_store: 'home-welcome-message' } %}
	{% else %}
		{% include 'snipplets/home/home-welcome-message.tpl' %}
	{% endif %}

{% elseif section_select == 'institutional' %}

	{#  **** Institutional message **** #}
	{% if show_help or (show_component_help and not has_institutional_message) %}
		{% include 'snipplets/defaults/home/welcome_message_help.tpl' with { section: 'institutional', title: 'Mensaje institucional' | translate, data_store: 'home-institutional-message' } %}
	{% else %}
		{% include 'snipplets/home/home-welcome-message.tpl' with {institutional: true} %}
	{% endif %}

{% elseif section_select == 'testimonials' %}

	{#  **** Testimonials slider **** #}
	<section class="section-testimonials-home position-relative" data-store="home-testimonials">
		{% if show_help or (show_component_help and not has_testimonials) %}
			{% snipplet 'defaults/home/testimonials_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-testimonials.tpl' %}
		{% endif %}
	</section>

{% elseif section_select == 'brands' %}

	{#  **** Brands **** #}
	<section class="section-brands-home" data-store="home-brands">
		{% if show_help or (show_component_help and not has_brands) %}
			{% snipplet 'defaults/home/brands_help.tpl' %}
		{% else %}
			{% include 'snipplets/home/home-brands.tpl' %}
		{% endif %}
	</section>

{% elseif section_select == 'modules' %}

	{#  **** Modules image and text **** #}
	{% if show_help or (show_component_help and not has_image_and_text_module) %}
		{% include 'snipplets/defaults/home/image_text_modules_help.tpl' %}
	{% else %}
		{% include 'snipplets/home/home-banners.tpl' with {module: true} %}
	{% endif %}

{% endif %}
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/" lang="{% for language in languages %}{% if language.active %}{{ language.lang }}{% endif %}{% endfor %}">
	<head>
		<link rel="preconnect" href="{{ store_resource_hints }}"/>
		<link rel="dns-prefetch" href="{{ store_resource_hints }}"/>
		<link rel="preconnect" href="https://fonts.googleapis.com"/>
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin/>
		<link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<meta name="viewport" content="width=device-width, initial-scale=1"/>
		<title>{{ page_title }}</title>
		<meta name="description" content="{{ page_description }}"/>
		<link rel="preload" as="style" href="{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400,700') }}"/>
		<link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style"/>
		<link rel="preload" href="{{ 'css/style-colors.scss' | static_url }}" as="style"/>

		{# Preload LCP home, category and product page elements #}
		{% snipplet 'preload-images.tpl' %}
		{{ component('social-meta') }}

		<style>
			{# Font families #}
			{{component('fonts',{font_weights: '400,700',font_settings: 'settings.font_headings, settings.font_rest'})}}
			{# General CSS Tokens #}
			{% include "static/css/style-tokens.tpl" %}
			{# Global Font Override #}
			* {
				font-family: 'Montserrat', sans-serif !important;
			}
		</style>

		{# Critical CSS #}
		{{ 'css/style-critical.scss' | static_url | static_inline }}
		{# Colors and fonts used from settings.txt and defined on theme customization #}
		{{ 'css/style-colors.scss' | static_url | static_inline }}
		{# Load async styling not mandatory for first meaningfull paint #}
		<link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">
		{# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}
		<style>{{settings.css_code | raw}}</style>

		{# Javascript: Needed before HTML loads #}
		{# Defines if async JS will be used by using script_tag(true) #}
		{% set async_js = true %}
		{# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}
		{% set nojquery = true %}
		{# Jquery async by adding script_tag(true) #}
		{% if load_jquery %}
			{{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}
		{% endif %}
		{# Loads private Tiendanube JS #}
		{% head_content %}
		{# Structured data to provide information for Google about the page content #}
		{{ component('structured-data') }}
	</head>
	<body
		class="{% if customer %}customer-logged-in{% endif %} template-{{ template | replace('.', '-') }}">

		{# Theme icons #}
		{% include "snipplets/svg/icons.tpl" %}
		{# Facebook comments on product page #}
		{% if template == 'product' %}
			{# Facebook comment box JS #}
			{% if settings.show_product_fb_comment_box %} {{ fb_js }} {% endif %}
			{# Pinterest share button JS #}
			{{ pin_js }}
		{% endif %}

		{# Back to admin bar #}
		{{back_to_admin}}

		{# Header = Advertising + Nav + Logo + Search + Ajax Cart #}
		{% snipplet "header/header.tpl" %}
		{% if settings.show_tab_nav %} {% snipplet "navigation/navigation-tabs.tpl" %} {% endif %}

		{# Page content #}
		{% template_content %}
		{# Quickshop modal #}
		{% snipplet "grid/quick-shop.tpl" %}
		{# WhatsApp chat button #}
		{% snipplet "whatsapp-chat.tpl" %}
		{# Footer #}
		{% snipplet "react/footer.tpl" %}

		{% if cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
			{# Minimum used for free shipping progress messages. Located on header so it can be accesed everywhere with shipping calculator active or inactive #}
			<span class="js-ship-free-min hidden" data-pricemin="{{ cart.free_shipping.min_price_free_shipping.min_price_raw }}"></span>
			<span class="js-free-shipping-config hidden" data-config="{{ cart.free_shipping.allFreeConfigurations }}"></span>
			<span class="js-cart-subtotal hidden" data-priceraw="{{ cart.subtotal }}"></span>
			<span class="js-cart-discount hidden" data-priceraw="{{ cart.promotional_discount_amount }}"></span>
		{% endif %}

		{# Javascript used in the store #}
		<script type="text/javascript">
			{# Libraries that do NOT depend on other libraries,e.g : Jquery #}
			{% include "static/js/external-no-dependencies.js.tpl" %}
			{# LS.ready.then function waits to Jquery and private Tiendanube JS to be loaded before executing what´s inside #}
			{# Libraries that requires Jquery to work #}
			{# Specific store JS functions: product variants,cart,shipping,etc #}
			LS.ready.then(function () {
				{% include "static/js/external.js.tpl" %}
				{% include "static/js/store.js.tpl" %}
			});
		</script>

		{# Google reCAPTCHA on register page #}
		{% if template == 'account.register' %}
			{% if not store.hasContactFormsRecaptcha() %}
				{{ '//www.google.com/recaptcha/api.js' | script_tag(true) }}
			{% endif %}

			<script type="text/javascript">
				var recaptchaCallback = function () {jQueryNuvem('.js-recaptcha-button').prop('disabled', false);};
			</script>
		{% endif %}

		{# Google survey JS for Tiendanube Survey #}
		{{ component('google-survey') }}

		{# Store external codes added from admin #}
		{% if store.assorted_js %}
			<script>
				LS.ready.then(function () {
					var trackingCode = jQueryNuvem.parseHTML('{{ store.assorted_js| escape("js") }}', document, true);
					jQueryNuvem('body').append(trackingCode);
				});
			</script>
		{% endif %}

		<script>
		(function() {
			var header = document.querySelector('.js-head-main');
			if (!header) return;
			var adbar = document.querySelector('.section-adbar');
			var lastY = 0;
			var ticking = false;
			var shrunkThreshold = 60;
			var adbarThreshold = 40;

			function onScroll() {
				var y = window.pageYOffset;

				// if (y > shrunkThreshold && y > lastY) {
				// 	if (!header.classList.contains('hdr-shrunk')) {
				// 		header.classList.add('hdr-shrunk');
				// 	}
				// } else if (y < lastY || y <= 0) {
				// 	if (header.classList.contains('hdr-shrunk')) {
				// 		header.classList.remove('hdr-shrunk');
				// 	}
				// }

				if (adbar) {
					if (y > adbarThreshold) {
						if (!adbar.classList.contains('zaleski-adbar-hidden')) {
							adbar.classList.add('zaleski-adbar-hidden');
						}
					} else {
						if (adbar.classList.contains('zaleski-adbar-hidden')) {
							adbar.classList.remove('zaleski-adbar-hidden');
						}
					}
				}

				if (typeof offsetCategories === 'function') {
					offsetCategories();
				}

				lastY = y;
				ticking = false;
			}

			window.addEventListener('scroll', function() {
				if (!ticking) {
					requestAnimationFrame(onScroll);
					ticking = true;
				}
			});
		})();
		</script>


		{# React Widgets Bundle #}
		{% include "snipplets/react/react-bundle.tpl" %}
	</body>
</html>


{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>

{# Header #}

<header class="hdr head-main js-head-main" data-store="head" style="z-index: 1000;">

    {# Advertising bar #}
    {% if settings.ad_bar %}
        {% snipplet "header/header-advertising.tpl" %}
    {% endif %}

    <div class="hdr-in">
        {# Hamburger menu (mobile) #}
        <div class="hdr-left">
            <div id="react-zaleski-mobile-menu" class="hamburger js-toggle-mobile-menu" aria-label="Menu"></div>
        </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            if (window.renderZaleskiMobileMenu) {
            window.renderZaleskiMobileMenu('react-zaleski-mobile-menu', {
                links: [
                {% for item in navigation %}
                    { label: '{{ item.name }}', url: '{{ item.url | setting_url }}' },
                {% endfor %}
                ]
            });
            }
        });
    </script>


        {# Logo #}
        <a href="{{ store.url }}" class="logo">
            {{ component('logos/logo', {
                logo_img_classes: 'logo-img-small',
                logo_text_classes: 'h3 m-0',
                logo_size: 'large'
            }) }}
        </a>

        {# Header actions: Search, Account, Cart #}
        <div class="hdr-act">
            {# Search #}
            <span class="utilities-container">
                <a href="#" class="js-modal-open js-search-button utilities-link utilities-item" data-toggle="#nav-search" aria-label="{{ 'Buscador' | translate }}">
                    <svg style="fill: none; important!" viewBox="0 0 24 24" stroke-width="1.5"><circle cx="11" cy="11" r="8"></circle><path d="M21 21l-4.35-4.35"></path></svg>
                </a>
            </span>

            {# Account #}
            {% include "snipplets/header/header-utilities.tpl" with {use_account: true} %}

            {# Cart #}
            {% include "snipplets/header/header-utilities.tpl" %}
        </div>
    </div>

    {# Main navigation #}
    <nav class="mainnav">
        <ul>
            {% for item in navigation %}
                <li><a href="{{ item.url | setting_url }}" class="{{ item.current ? 'selected' : '' }}">{{ item.name }}</a></li>
            {% endfor %}
        </ul>
    </nav>

    {% include "snipplets/notification.tpl" with {order_notification: true} %}

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            var adbar = document.querySelector('.section-adbar');
            
            if (adbar) {
                window.addEventListener('scroll', function() {
                    if (window.scrollY > 40) {
                        adbar.classList.add('zaleski-adbar-hidden');
                    } else {
                        adbar.classList.remove('zaleski-adbar-hidden');
                    }
                });
            }
        });
        </script>

</header>

{# Show cookie validation message #}

{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Add to cart notification #}

{% if settings.ajax_cart %}
    {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
{% endif %}

{# Cross selling promotion notification on add to cart #}

{% embed "snipplets/modal.tpl" with {
    modal_id: 'js-cross-selling-modal',
    modal_class: 'bottom modal-bottom-sheet h-auto overflow-none modal-body-scrollable-auto',
    modal_header_title: true,
    modal_header_class: 'p-4 w-100',
    modal_position: 'bottom',
    modal_transition: 'slide',
    modal_footer: true,
    modal_width: 'centered-md m-0 p-0 modal-full-width modal-md-width-400px'
} %}
    {% block modal_head %}
        {{ '¡Descuento exclusivo!' | translate }}
    {% endblock %}

    {% block modal_body %}
        {# Promotion info and actions #}

        <div class="js-cross-selling-modal-body" style="display: none"></div>
    {% endblock %}
{% endembed %}

{% include "snipplets/header/header-modals.tpl" %}

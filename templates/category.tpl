{% set has_filters_available = products and has_filters_enabled and (filter_categories is not empty or product_filters is not empty) %}

{# Only remove this if you want to take away the theme onboarding advices #}
{% set show_help = not has_products %}
{% paginate by 12 %}

{% if not show_help %}

{% set is_theme_active = false %}
{% if settings.enable_theme_banners and category.description and '[TEMA]' in category.description %}
    {% set is_theme_active = true %}
{% endif %}

{% set category_banner = (category.images is not empty) or ("banner-products.jpg" | has_custom_image) %}
{% if category_banner and not is_theme_active %}
    {% include 'snipplets/category-banner.tpl' %}
{% endif %}
<section class="container-fluid mt-3 d-md-none">
	{% include "snipplets/breadcrumbs.tpl" %}
</section>

{% set desktop_category_controls_transparent = settings.filters_desktop_modal and settings.head_fix_desktop and settings.head_transparent and settings.head_transparent_type == 'all' %}

{% if is_theme_active %}

    {% set has_category_images = category.images is not empty %}
    <div class="hero-theme-banner" style="position: relative; width: 100%; height: 60vh; overflow: hidden;">
        {% if has_category_images %}
            <img src="{{ category.images | first | category_image_url('original') }}" style="width: 100%; height: 100%; object-fit: cover;" alt="{{ category.name }}" />
        {% endif %}
        <div style="position: absolute; inset: 0; background: rgba(0,0,0,0.4); display: flex; align-items: center; justify-content: center;">
            <h1 style="color: #fff; font-size: 48px; text-transform: uppercase; font-weight: 600; letter-spacing: 2px;">{{ category.name }}</h1>
        </div>
    </div>

{% endif %}

<div class="d-none d-md-block">
    {% include "snipplets/breadcrumbs.tpl" %}
</div>

<div id="react-zaleski-category-top"></div>

<script>
(function() {
    function initCategoryTop() {
        if (window.renderZaleskiCategoryTop) {
            var productCount = "{{ category.products_count | default(search.results_count) }}";
            var countLabel = productCount === "1" ? "produto" : "produtos";

            var currentSort = "{{ sort_by | default('user-defined') }}"; 
            var rawSortOptions = [
                { label: "Destaque", value: "user-defined" },
                { label: "Mais Vendidos", value: "best-selling" },
                { label: "Mais Novo ao mais Antigo", value: "created-descending" },
                { label: "Mais Antigo ao mais Novo", value: "created-ascending" },
                { label: "Preço: Menor ao Maior", value: "price-ascending" },
                { label: "Preço: Maior ao Menor", value: "price-descending" },
                { label: "A - Z", value: "alpha-ascending" },
                { label: "Z - A", value: "alpha-descending" }
            ];

            var sortOptionsList = [];
            var activeSortLabel = "Destaque";

            for (var i = 0; i < rawSortOptions.length; i++) {
                var isActive = currentSort === rawSortOptions[i].value;
                if (isActive) {
                    activeSortLabel = rawSortOptions[i].label;
                }
                sortOptionsList.push({
                    label: rawSortOptions[i].label,
                    url: "?sort_by=" + rawSortOptions[i].value,
                    active: isActive
                });
            }

            {% set descriptionHeader = category.description %}
            {% if '[TEMA]' in category.description %}
                {% set descriptionHeader = category.description | split('[TEMA]') | join('') %}
            {% endif %}

            var totalAppliedFilters = 0;
            
            {% if product_filters is not empty %}
                {% for product_filter in product_filters %}
                    {% for value in product_filter.values %}
                        {% if value.selected %}
                            totalAppliedFilters++;
                        {% endif %}
                    {% endfor %}
                {% endfor %}
            {% endif %}

            var props = {
                title: "{{ category.name | default(search.query) | escape('js') }}",
                countText: productCount + " " + countLabel,
                description: "{{ descriptionHeader | escape('js') }}",
                filterCount: totalAppliedFilters, 
                activeSortLabel: activeSortLabel,
                sortOptions: sortOptionsList
            };

            window.renderZaleskiCategoryTop('react-zaleski-category-top', props);
        }
    }
    
    if (document.readyState !== 'loading') initCategoryTop();
    else document.addEventListener('DOMContentLoaded', initCategoryTop);
})();
</script>

<section class="js-category-controls-prev category-controls-sticky-detector"></section>
{% include 'snipplets/grid/filters-modals.tpl' %}
{% include "snipplets/grid/filters-sidebar.tpl" %}

<div id="react-zaleski-product-grid"></div>

<script>
(function() {
    function initProductGrid() {
        if (window.renderZaleskiProductGrid) {
            var productsList = [];
            
            {% for product in products %}
                var colorList = [];
                var seenColors = [];
                
                {% if product.variations %}
                    {% for variation in product.variations %}
                        {% for option in variation.options %}
                            {% if option.custom_data %}
                                if (!seenColors.includes("{{ option.custom_data }}")) {
                                    seenColors.push("{{ option.custom_data }}");
                                    colorList.push({ hex: "{{ option.custom_data }}" });
                                }
                            {% endif %}
                        {% endfor %}
                    {% endfor %}
                {% endif %}

                {% set product_badge = 'null' %}
                {% if product.compare_at_price > product.price %}
                    {% set product_badge = '"Oferta"' %}
                {% else %}
                    {% set tags_string = product.tags | join(',') | lower %}
                    {% if 'lançamento' in tags_string or 'novo' in tags_string %}
                        {% set product_badge = '"Lançamento"' %}
                    {% elseif 'best seller' in tags_string or 'destaque' in tags_string %}
                        {% set product_badge = '"Best Seller"' %}
                    {% endif %}
                {% endif %}

                productsList.push({
                    id: {{ product.id }},
                    url: "{{ product.url | escape('js') }}",
                    name: "{{ product.name | escape('js') }}",
                    price: "{{ product.price | money | escape('js') }}",
                    comparePrice: {% if product.compare_at_price > product.price %}"{{ product.compare_at_price | money | escape('js') }}"{% else %}null{% endif %},
                    mainImage: "{{ product.featured_image | product_image_url('large') | escape('js') }}",
                    hoverImage: {% if product.other_images | length > 1 %}"{{ product.other_images[1] | product_image_url('large') | escape('js') }}"{% else %}null{% endif %},
                    badge: {{ product_badge | raw }},
                    scarcityText: {% if product.stock > 0 and product.stock < 5 %}"Somente {{ product.stock }} restante{% if product.stock > 1 %}s{% endif %}"{% else %}null{% endif %},
                    colors: colorList
                });
            {% endfor %}

            var props = {
                products: productsList,
                pagination: {
                    hasNextPage: {{ pages.current < pages.amount ? 'true' : 'false' }},
                    nextPageUrl: "{{ pages.next | escape('js') }}",
                    showingText: "Mostrando {{ products | length }} de {{ category.products_count | default(search.results_count) }} produtos",
                    loadMoreText: "{{ 'Carregar mais produtos' | translate | escape('js') }}"
                }
            };

            window.renderZaleskiProductGrid('react-zaleski-product-grid', props);
        }
    }

    if (document.readyState !== 'loading') initProductGrid();
    else document.addEventListener('DOMContentLoaded', initProductGrid);
})();
</script>

<div id="react-zaleski-category-seo"></div>

<script>
(function() {
    function initCategorySeo() {
        if (window.renderZaleskiCategorySeo) {
            
            var dynamicTitle = "{{ settings.category_seo_title | escape('js') }}";
            if (!dynamicTitle) {
                dynamicTitle = "{{ category.name | default(search.query) | escape('js') }} — {{ store.name | escape('js') }}";
            }

            var props = {
                title: dynamicTitle,
                description: "{{ settings.category_seo_description | escape('js') }}"
            };

            window.renderZaleskiCategorySeo('react-zaleski-category-seo', props);
        }
    }

    if (document.readyState !== 'loading') initCategorySeo();
    else document.addEventListener('DOMContentLoaded', initCategorySeo);
})();
</script>

<script>
window.addEventListener('zaleski:applyFilters', async function(e) {
    var url = e.detail.url;
    
    window.history.pushState({ path: url }, '', url);
    
    try {
        var response = await fetch(url);
        var html = await response.text();
        
        var parser = new DOMParser();
        var newDoc = parser.parseFromString(html, 'text/html');
        
        var targets = [
            'react-zaleski-category-top',
            'react-zaleski-filters-sidebar',
            'react-zaleski-product-grid'
        ];
        
        targets.forEach(function(id) {
            var oldEl = document.getElementById(id);
            var newEl = newDoc.getElementById(id);
            if (oldEl && newEl) {
                oldEl.outerHTML = newEl.outerHTML;
            }
        });
        
        var scripts = newDoc.querySelectorAll('script');
        scripts.forEach(function(script) {
            var isTargetScript = targets.some(function(id) {
                return script.innerHTML.includes("'" + id + "'") || script.innerHTML.includes('"' + id + '"');
            });
            
            if (isTargetScript) {
                var newScript = document.createElement('script');
                newScript.innerHTML = script.innerHTML;
                document.body.appendChild(newScript);
                setTimeout(function() { newScript.remove(); }, 100);
            }
        });

        window.scrollTo({ top: 0, behavior: 'smooth' });

    } catch (err) {
        console.error('Falha no AJAX de filtros, recorrendo ao reload:', err);
        window.location.href = url;
    }
});
</script>
{% elseif show_help %}
	{# Category Placeholder #}
	{% include 'snipplets/defaults/show_help_category.tpl' %}
{% endif %}